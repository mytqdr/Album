<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="java.util.*" 
import="org.hibernate.*"
import="net.*"
import="org.hibernate.cfg.Configuration"
errorPage="errorPage.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
//HttpSession HSsession = request.getSession();
String rand = request.getParameter("text");//验证码
if(rand!=null)//有验证码说明要登录
{
	if(!rand.equals(session.getAttribute("rand")))//验证码输入错误
	{
		out.print("<script>alert(\"验证码输入错误！\");</script>");
	}	
	else
	{
		util sql = new util();
		sql.begin();
		Session hsession = sql.getSession(); //hibernate初始化
		hsession.beginTransaction();  
		String username = request.getParameter("username");//获取用户名和密码
		String password = request.getParameter("password");
		if(username.equals(""))//空值判断   //其实可以用js来判断 但是我都写好了 懒得改
		{
			out.print("<script>alert(\"请输入用户名！\");</script>");
			return;
		}
		if(password.equals(""))
		{
			out.print("<script>alert(\"请输入密码！\");</script>");
			return;
		}
		List query= hsession.createSQLQuery("select * from user where username = '"+username+"' and password = '"+password+"' ").addEntity(user.class).list();;
		Iterator rs = query.iterator();//查询是否有符合的
		if(rs.hasNext())
		{
			user nuser =(user)rs.next();      //有的话 存数据到session
			login nlogin = new login();
			nlogin.setUsername(nuser.getUsername());
			nlogin.setId(nuser.getId());
			nlogin.setIslogin(true);
			session.setAttribute("login",nlogin); 
			out.print("<script>alert(\"欢迎回来,"+nuser.getUsername()+".\");location.href=\"index.html\";</script>");
		//	response.sendRedirect("index.jsp"); 
			return;
		}
		else
		{
			out.print("<script>alert(\"用户名或密码错误！\");</script>");
		}
		hsession.close();  
	}
	
}

login nlogin = (login)session.getAttribute("login");//判断是不是在逗我玩
if(nlogin!=null && nlogin.isIslogin())
{
	out.print("<script>alert(\"你已登录！\");location.href=\"index.html\";</script>");
//	response.sendRedirect("index.jsp"); 
	return;
}

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>登录</title>
</head>
<body>

<form action="#" method="post">
  用户名
  <input name="username" id="username"  type="text" />
  <p>
    密码
      <input type="password" name="password" id="password" />
  </p>
  <p>
    <input type="text" name="text" id="text" />  <img src="../randCodeImage" />
  </p>
  <p>
    <input type="submit" value="登录" />
  </p>
</form>
</body>
</html>