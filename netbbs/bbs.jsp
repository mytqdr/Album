<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="java.util.*" import="java.text.*" 
import="java.math.*"
import="org.hibernate.*"
import="net.*"
import="org.hibernate.cfg.Configuration"
errorPage="errorPage.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>bbs</title>
</head>
<%
util sql = new util();
sql.begin();
Session hsession = sql.getSession(); //hibernate初始化
hsession.beginTransaction();  
//HttpSession HSsession = request.getSession();

java.util.Date date= new java.util.Date();//创建一个时间对象，获取到当前的时间
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置时间显示格式
String nowtime = sdf.format(date);//将当前时间格式化为字符串



login nlogin = (login)session.getAttribute("login");//获取登录状态

String rand = request.getParameter("text");//验证码
String text = request.getParameter("textarea");//内容
String title = request.getParameter("title");//标题

String pages = request.getParameter("page");//页数

if(rand!=null)//如果有验证码 说明用户要发帖
{
	if(!rand.equals(session.getAttribute("rand")))//验证码输入错误
	{
		session.setAttribute("otext",text);
		session.setAttribute("otitle",title);
		out.print("<script>alert(\"验证码输入错误！\");</script>");
	}
	else
	{
		if(nlogin!=null && nlogin.isIslogin())//小伙子 登录了没
		{
			post npost = new post();//帖子
			npost.setViewers(0);
			npost.setPoid(nlogin.getId());//上传者ID
			npost.setTitle(title);
			npost.setTime(nowtime);
			
			hsession.clear();
			int rpostid =(int)hsession.save(npost); 
			//hsession.getTransaction().commit(); 
			
			replay nreplay = new replay();//内容
			nreplay.setPoid(nlogin.getId());//上传者ID
			nreplay.setPostid(rpostid);//帖子ID
			nreplay.setTime(nowtime);
			nreplay.setMain(text);
			//hsession.clear();
			hsession.save(nreplay); 
			hsession.getTransaction().commit(); 
		} 
		else//没登录就帮你暂存一下发帖的内容 登录了给你恢复
		{
			session.setAttribute("otext",text);
			session.setAttribute("otitle",title);
			out.print("<script>alert(\"你尚未登录！\");location.href=\"login.jsp\";</script>");
			return;
		}
	}
}

String otext = (String)session.getAttribute("otext");//存在session里的记录
String otitle = (String)session.getAttribute("otitle");
if(otext != null)//有记录就拿出来 清空session
{
	session.removeAttribute("otext");
}
else
{
	otext = "";
}
if(otitle!=null)
{
	session.removeAttribute("otitle");
}
else
{
	otitle = "";
}


if(pages == null)//默认page1
{
	pages = "1";
}

int ipage = Integer.parseInt(pages);//string转int
int limitnum = 10; 	//持续几条
int limit =(ipage-1)*limitnum; //从第几条开始

List query= hsession.createSQLQuery("select post.title as title,post.id as postid, post.viewers as viewers, user.username as username,counts.replycount from post,user,(select postid,count(id) as replycount from replay group by postid)counts WHERE post.poid = user.id and counts.postid = post.id order by post.time desc LIMIT "+limit+","+limitnum).list();//查询帖子
Iterator rs = query.iterator();
//7.31 联合查询增加的发帖人的信息
//8.5 类聚嵌套查询 增加了帖子的回帖数量 



%>
<body align="center">
<table width="595" height="57" border="0" align="center">
  <tr>
    <td align="left" valign="middle" colspan="3">
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
    <td width="262" align="right" valign="middle"></td>
    <td width="42" align="right" valign="middle">
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
    <td width="47" align="right" valign="middle"><a href="register.jsp">注册</a></td>
  </tr>
<%
while(rs.hasNext())//获取帖子查询结果
{
	Object[] post=(Object[])rs.next();//传值给变量
    String ntitle=(String)post[0];
	int npostid=(int)post[1];
	int nviewers=(int)post[2];
	String username=(String)post[3];
	BigInteger nrecounts=(BigInteger)post[4];
	
//post npost =(post)rs.next();      //变量输出
out.print("<tr><td  align=\"center\">"+nrecounts+"</td><td colspan=\"3\"><a href=\"post.jsp?id="+npostid+"\">");
out.print(ntitle);
out.print("</td><td align=\"right\">"+username+"</td></tr>");
}
List query2= hsession.createSQLQuery("select count(id) as counts from post").list();//查询所有帖子总数
Iterator rs2 = query2.iterator();
BigInteger postcounts=(BigInteger)rs2.next();
int ipostc = postcounts.intValue();//转成int
int maxpages = (ipostc/limitnum)+1;
out.print("<tr><td  align=\"center\" colspan=\"4\"><a href=\"index.jsp?page=1\">首页</a>&nbsp;");
if((ipage-1)>=1)
{
	out.print("<a href=\"index.jsp?page="+(ipage-1)+"\">上一页</a>&nbsp;");
}
for(int i = -3;i<=3;i++){ 
	if((ipage+i)>0 && (ipage+i)<=maxpages)//不如果超出页数范围
	{
		if(i==0)
		{
			out.print(ipage+"&nbsp;");
		}
		else
		{
			out.print("<a href=\"index.jsp?page="+(ipage+i)+"\">["+(ipage+i)+"]</a>&nbsp;");
		}
	}
}
if((ipage+1)<=maxpages)
{
	out.print("<a href=\"index.jsp?page="+(ipage+1)+"\">下一页</a>&nbsp;");
}
out.print("<a href=\"index.jsp?page="+maxpages+"\">末页</a></td></tr>");
hsession.close();  //不加这个服务器内存会爆
  %>
  <form action="#" method="post" name="form1" id="form1">
<tr><td colspan="4">

  标题
      <input type="text" name="title" id="title" value="<%=otitle%>"  />
  </td>
  <tr><td colspan="4">
    <textarea name="textarea" id="textarea" cols="45" rows="5" ><%=otext%></textarea>
 </td> </tr><tr>
 <td width="54" align="right">
    <p>
      <input type="submit" name="button" id="button" value="发表" />
    </p>
 <td colspan="2" align="right"><input type="text" name="text" id="text" /> </td><td>  <img src="../randCodeImage" /></tr></form></table>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p></p>
</body>
</html>