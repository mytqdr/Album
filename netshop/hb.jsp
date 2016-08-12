<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" 
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
hsession.beginTransaction();  
user testuser = new user();  
testuser.setTime("0");
testuser.setUsername("12345");
testuser.setPassword("");
testuser.setIcon("");
testuser.setPoint(0);
hsession.save(testuser); 
hsession.getTransaction().commit();   
hsession.close();  
 %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
</head>
1
<body>
</body>
</html>