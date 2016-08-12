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

String newsid = request.getParameter("id");//ID
if(newsid == null)//如果没有公告ID
{
	out.print("<script>alert(\"公告不存在！\");location.href=\"index.html\";</script>");
//	response.sendRedirect("index.jsp"); 
	return;
}
List query= hsession.createSQLQuery("select news.time,news.title,news.main,user.username from news,user where news.poid=user.id and news.id ="+newsid).list();
Iterator rs = query.iterator();
String rntime;
String rntitle;
String rnmain;
String rnname;
if(rs.hasNext())//查询结果
{
	Object[] rnews=(Object[])rs.next();//传值给变量
	rntime=(String)rnews[0];
	rntitle=(String)rnews[1];
	rnmain=(String)rnews[2];
	rnname=(String)rnews[3];

}
else
{
	out.print("<script>alert(\"公告不存在！\");location.href=\"index.html\";</script>");
//	response.sendRedirect("index.jsp"); 
	return;
}
%>
<body>
<table width="912" height="606" border="1">
  <tr>
    <td height="23" align="center">&nbsp;</td>
  </tr>
   <tr>
    <td height="60" align="center"><strong><%=rntitle%></strong></td>
  </tr>
  <tr>
    <td height="31" align="center"><%=rntime%></td>
  </tr>
  <tr>
    <td height="28" align="center"><%=rnname%></td>
  </tr>
   <tr>
    <td height="450" align="left" valign="top"><%=rnmain%></td>
  </tr>
</table>
</body>
</html>