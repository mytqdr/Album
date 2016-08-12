<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="java.util.*" 
import="org.hibernate.*"
import="net.*"
import="org.hibernate.cfg.Configuration"
errorPage="errorPage.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>注销</title>
</head>
<%
login nlogin = (login)session.getAttribute("login");//获取登录状态
if(nlogin!=null && nlogin.isIslogin())//若登录
{
	nlogin.setUsername("");
	nlogin.setId(0);
	nlogin.setIslogin(false);//清除数据
	session.setAttribute("login",nlogin); 
	out.print("<script>alert(\"你已注销！\");location.href=\"index.html\";</script>");
	//	response.sendRedirect("index.jsp"); 
	return;
}
else
{
	out.print("<script>alert(\"你尚未登录！\");location.href=\"index.html\";</script>");//
}
%>
<body>
</body>
</html>