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
<title>news</title>
</head>
<%
util sql = new util();
sql.begin();
Session hsession = sql.getSession(); //hibernate初始化
hsession.beginTransaction();  

login nlogin = (login)session.getAttribute("login");//获取登录状态

String rand = request.getParameter("text");//验证码
String text = request.getParameter("textarea");//内容
String title = request.getParameter("title");//标题

String pages = request.getParameter("page");//页数

String newsid = request.getParameter("newsid");//获取删除请求
if(newsid != null)//如果要删除
{
	List query2= hsession.createSQLQuery("select * from news where poid = "+nlogin.getId()+" and id ="+newsid).addEntity(news.class).list();//判断权限 登陆者是否是公告的发布者
	Iterator rs2 = query2.iterator();
	if(rs2.hasNext())//如果是
	{
		news delnews =(news)rs2.next(); //获取单贴实例	
		hsession.delete(delnews);//删除 
		out.print("<script>alert(\"公告已删除!\");</script>");
 	 	hsession.getTransaction().commit();//提交
	}
	else//如果不是
	{
		out.print("<script>alert(\"删除失败!无权限或公告不存在!\");</script>");
	}
}



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
		if(nlogin!=null && nlogin.isIslogin())//登录了没
		{
			news nnews = new news();//帖子
			nnews.setMain(text);
			nnews.setPoid(nlogin.getId());//上传者ID
			nnews.setTitle(title);
			
			java.util.Date date= new java.util.Date();//创建一个时间对象，获取到当前的时间
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置时间显示格式
			String nowtime = sdf.format(date);//将当前时间格式化为字符
			
			nnews.setTime(nowtime);
			
			hsession.clear();
			hsession.save(nnews); 
			hsession.getTransaction().commit(); 
		} 
		else//没登录
		{
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

List query= hsession.createSQLQuery("select news.*,user.username from news,user WHERE news.poid = user.id order by news.time desc LIMIT "+limit+","+limitnum).list();//查询帖子
Iterator rs = query.iterator();
%>
<body>
<form id="form1" name="form2" method="post" action="#">
	<input name="newsid" id="newsid" type="hidden" value="" />
</form>
<script type="text/javascript">  //处理删除的确认
function delsubmit(newsid) {  
    var result = confirm("是否删除此贴?");  
    if (result == true) {  
    //    alert("帖子已删除."); 
		document.getElementById('newsid').value =newsid;
		document.form2.submit();
    }
}  
</script>  
<table width="626" height="57" border="0" align="center">
  <tr>
    <td align="left" valign="middle" colspan="3">
	<%
	if(nlogin!=null && nlogin.isIslogin())//按照是否登录来决定输出内容
	{
		out.print("你好,"+nlogin.getUsername());
		
	}
	else
	{
		out.print("<script>alert(\"你尚未登录！\");location.href=\"index.html\";</script>");
	return;
	}
    %></td>
    <td width="224" align="right" valign="middle"></td>
    <td width="87" align="right" valign="middle"><%
	
	out.print("<a href=\"logout.jsp\">注销</a>");
	
	
	%></td>
    <td width="35" align="right" valign="middle"><a href="register.jsp">注册</a></td>
  </tr>
  <%
while(rs.hasNext())//获取帖子查询结果
{
	Object[] rnews=(Object[])rs.next();//传值给变量
	int rnid=(int)rnews[0];//返回的ID
    String rntitle=(String)rnews[1];
	String rntime=(String)rnews[3];
	String rnname=(String)rnews[5];
	
//post npost =(post)rs.next();      //变量输出
out.print("<tr><td  align=\"center\">"+rntime.substring(0,10)+"</td><td colspan=\"3\"><a href=\"post.jsp?id="+rnid+"\">");
out.print(rntitle);
out.print("</td><td align=\"right\">"+rnname+"<input type=\"button\" name=\"button\" id=\"button\" value=\"删除\"  onClick=\"delsubmit("+rnid+");\" /></td></tr>");
}
List query2= hsession.createSQLQuery("select count(id) as counts from news").list();//查询所有帖子总数
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
    <tr>
      <td colspan="4"> 标题
      <input type="text" name="title" id="title" value="<%=otitle%>"  />
  </td>
  <tr><td colspan="4">
    <textarea name="textarea" id="textarea" cols="45" rows="5" ><%=otext%></textarea>
 </td> </tr><tr>
 <td width="90" align="right">
    <p>
        <input type="submit" name="button" id="button" value="发表" />
      </p></td>
      <td colspan="2" align="right"><input type="text" name="text" id="text" /></td>
      <td><img src="../randCodeImage" /></td>
    </tr>
  </form>
</table>
</body>
</html>