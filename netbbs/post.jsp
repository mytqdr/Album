<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="java.util.*" import="java.text.*" 
import="org.hibernate.*"
import="net.*"
import="org.hibernate.cfg.Configuration"
errorPage="errorPage.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
util sql = new util();
sql.begin();
Session hsession = sql.getSession();
hsession.beginTransaction();   //hibernate初始化

java.util.Date date= new java.util.Date();//创建一个时间对象，获取到当前的时间
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置时间显示格式
String nowtime = sdf.format(date);//将当前时间格式化为字符串



String postid = request.getParameter("id");//获取帖子ID

login nlogin = (login)session.getAttribute("login");//获取登录信息


String oreplay = (String)session.getAttribute("oreplay");
String rand = request.getParameter("text");//验证码
String text = request.getParameter("textarea");//内容
if(oreplay != null)//有记录就拿出来 清空session
{
	session.removeAttribute("oreplay");
}
else
{
	oreplay = "";
}
boolean totop = false;//顶贴判断 如果有回帖 那么在刷新访问人数时顺带刷新帖子的时间
if(rand!=null)//如果有验证码 说明有回帖
{
	if(!rand.equals(session.getAttribute("rand")))//验证码输入错误
	{
		out.print("<script>alert(\"验证码输入错误！\");</script>");
	}
	else
	{
		if(nlogin!=null && nlogin.isIslogin())//登录了没
		{ 
			
			replay nreplay = new replay();//内容
			nreplay.setPoid(nlogin.getId());//上传者ID
			nreplay.setPostid(Integer.parseInt(postid));//帖子ID
			nreplay.setTime(nowtime);
			nreplay.setMain(text);
			//hsession.clear();
			totop = true; //顶贴
			hsession.save(nreplay); 
		//	hsession.getTransaction().commit(); 提交由下面的计数器+1一并提交
		} 
		else//没登录就帮你暂存一下发帖的内容 登录了给你恢复
		{
			session.setAttribute("oreplay",text);
			out.print("<script>alert(\"你尚未登录！\");location.href=\"login.jsp\";</script>");
			return;
		}
	}
}




String delreid = request.getParameter("replayid");//获取删除请求
if(delreid != null)//如果要删除
{
	List query2= hsession.createSQLQuery("select replay.* from replay,post where replay.postid = post.id and (replay.poid = "+nlogin.getId()+" or post.poid = "+nlogin.getId()+") and replay.id ="+delreid).addEntity(replay.class).list();//判断权限 登陆者是否是帖子的发布者 or 回贴发布者
	Iterator rs2 = query2.iterator();
	if(rs2.hasNext())//如果是
	{
	//	out.print("<script>alert(\""+delreid+"\");</script>");
	//要删除整个帖子怎么办 难搞了
	//思路 在这里整个判断 
	//查询一下这个帖子第一个回帖 如果删的是他 顺带删除POST里的数据
	//然后查出所有的回帖 拿循环 全删
	//早知道我就把第一个回帖放到POST里了
	
	//if(post
 	List query3= hsession.createSQLQuery("select id from replay where postid = "+postid+" order by time LIMIT 1 ").list();//获取第一个回帖ID
	Iterator rs3 = query3.iterator();
  	int mainreplayid=(int)rs3.next();//整贴的第一个帖子
	String mainid = mainreplayid+"";
	if(delreid.equals(mainid))//如果删的是第一个帖子
	{
		
		//执行整贴删除 包括 删除POST记录  删除replay里 postid 等于 post的id的记录
		
		//第一部分 删除post
		List query4= hsession.createSQLQuery("select * from post where id ="+postid).addEntity(post.class).list();//获取第一个回帖ID
		Iterator rs4 = query4.iterator();//查出post记录
		post delpost =(post)rs4.next();//实例化
		hsession.delete(delpost);//删除
		
		//第二部分 删除对应replay
		List query5= hsession.createSQLQuery("select * from replay where postid ="+postid).addEntity(replay.class).list();//获取第一个回帖ID
		Iterator rs5 = query5.iterator();//查出post记录
		//循环删除
		while(rs5.hasNext())
		{
			replay delreplay =(replay)rs5.next();//实例化
			hsession.delete(delreplay);//删除
		}
		//因为这个页面要被删除 提交 跳出
		hsession.getTransaction().commit(); //提交
		out.print("<script>alert(\"整个帖子已被删除！\");location.href=\"index.jsp\";</script>");
		return;//跳出
		
	}
	replay delreplay =(replay)rs2.next(); //获取单贴实例	
	hsession.delete(delreplay);//删除 提交由下面的计数器+1一并提交
	out.print("<script>alert(\"帖子已删除!\");</script>");
 // 	hsession.getTransaction().commit();
	}
	else//如果不是
	{
		out.print("<script>alert(\"删除失败!无权限或帖子不存在!\");</script>");
	}
}

if(postid == null)//如果没有帖子ID
{
	out.print("<script>alert(\"帖子不存在！\");location.href=\"index.jsp\";</script>");
//	response.sendRedirect("index.jsp"); 
	return;
}
List query1= hsession.createSQLQuery("select * from post WHERE id = "+postid).addEntity(post.class).list();
Iterator rs1 = query1.iterator();//查询帖子信息
String title = "";//帖子标题
int thispoid;//帖子ID
int viewers;//帖子浏览人数
if(rs1.hasNext())//如果帖子存在
{
	post thispost =(post)rs1.next(); //实例给变量赋值
	thispoid = thispost.getId();
	title = thispost.getTitle();
	viewers = thispost.getViewers();
	thispost.setViewers(++viewers);
	
	if(totop)//刷新时间以顶贴
	{
		thispost.setTime(nowtime);
	}
	
	hsession.save(thispost); //保存实例
	hsession.getTransaction().commit(); 
}
else
{
	out.print("<script>alert(\"帖子不存在！\");location.href=\"index.jsp\";</script>");
//	response.sendRedirect("index.jsp"); 
	return;
} 
	
	


%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=title%>-netbbs</title>
</head>
<script type="text/javascript">  //处理删除的确认
function delsubmit(reid) {  
    var result = confirm("是否删除此贴?");  
    if (result == true) {  
    //    alert("帖子已删除."); 
		document.getElementById('replayid').value =reid;
		document.form1.submit();
    }
}  
</script>  
<body>
<div align="center">

<form id="form1" name="form1" method="post" action="#">
<input name="replayid" id="replayid" type="hidden" value="" />
</form>
<table width="730" border="1">
  <tr>
  <td colspan="3" >
  <table width="730" border="0">
  <tr>
    <td width="222">
    <%
	if(nlogin!=null && nlogin.isIslogin())//按照是否登录来决定输出内容
	{
		out.print("你好,"+nlogin.getUsername());
		
	}
	else
	{
		out.print("你尚未登录.");
	}
    %>
    </td>
    <td width="293" align="right">
     <%
	
	if(nlogin!=null && nlogin.isIslogin())//按照是否登录来决定输出内容
	{
		out.print("<a href=\"logout.jsp\">注销</a>");
	}
	else
	{
		out.print("<a href=\"login.jsp\">登录</a>");
	}
	
	
	%> 
    </td>
    <td width="201">
    
    
    &nbsp;&nbsp;&nbsp;
    
    <a href="register.jsp">注册</a></td>
  </tr>
 </table>
 </td>
  <tr><td colspan="3" >
  <table width="730" border="0">
  <tr>
  	<td width="178"><a href="../">DrCy's Space</a>&gt;&gt;<a href="bbs.jsp">论坛</a>&gt;&gt;</td>
    <td width="341" height="33" align="center" valign="middle"><a href="#"><%=title%></a></td>
    <td width="197" height="33" align="right" valign="middle">已被访问<%=viewers%>次
    </td>
  </tr>
 </table>
    </td>
  </tr>
<%
List query= hsession.createSQLQuery("select user.username as username,user.icon as icon,user.point as point,replay.id as replayid,replay.time as time,replay.main as main,replay.poid as poid from user,replay,post where post.id=replay.postid and user.id = replay.poid and replay.postid ="+postid+" order by replay.time").list();
Iterator rs = query.iterator();//从数据库获取回帖信息

while(rs.hasNext())
{
	Object[] replay=(Object[])rs.next();//实例赋值
    String nusername=(String)replay[0];
	String nicon=(String)replay[1];
	int point=(int)replay[2];
	int nreplayid=(int)replay[3];
	String ntime=(String)replay[4];
	String nmain=(String)replay[5];
	int npoid=(int)replay[6];
	
	String icon ="default.jpg" ;//默认头像
	if(!nicon.equals(""))
	{
		icon = nicon;
	}
 	String button = "";
	if(nlogin!=null && nlogin.isIslogin())//判断是否有权限来删除帖子 
	{
		if(nlogin.getId()== npoid || nlogin.getId()== thispoid)//若是 输出一个删除按钮用以提交删除请求
		{
			button= "<input type=\"button\" name=\"button\" id=\"button\" value=\"删除\"  onClick=\"delsubmit("+nreplayid+");\" />";//删除按钮 通过JS把帖子的ID传给隐藏表单 再用POST提交给本页
		}
	}
	//if()
out.print("<tr><td width=\"146\" height=\"165\" align=\"center\" valign=\"middle\"><img src=\"image/"+icon+"\" width=\"120\" height=\"120\"/></p>"+nusername+"</td><td colspan=\"2\" align=\"left\" valign=\"top\"><p>"+nmain+"</td></tr><tr><td height=\"23\"></td><td width=\"271\" align=\"left\" valign=\"bottom\">"+button+"</td><td width=\"291\" align=\"right\" valign=\"bottom\">"+ntime+"</td></tr>");//输出回帖内容
  
  }
  
hsession.close(); //不想服务器内存溢出的话
%>
<tr><td  colspan="3" ><table  width="730"  border="0">
<form action="#" method="post" name="form2" id="form2">
 <tr>
   <td width="179"> </td><td colspan="2">
    <textarea name="textarea" id="textarea" cols="45" rows="5" ><%=oreplay%></textarea></td><td width="195" ></td>
</tr>
  <tr><td></td><td width="218">
    <input type="submit" name="button" id="button" value="发表" />
    <input type="text" name="text" id="text" /></td><td width="120">
  <img src="../randCodeImage" /></td>
    <td>  </td></tr>
</form></table></table></div>
</body>
</html>