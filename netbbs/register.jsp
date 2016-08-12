<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" import="java.util.*" import="java.text.*" 
import="org.hibernate.*"
import="net.*"
import="org.hibernate.cfg.Configuration"
errorPage="errorPage.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>注册</title>
</head>
<%
String rand = request.getParameter("rand");//验证码
if(rand!=null)
{
	if(!rand.equals(session.getAttribute("rand")))//验证码输入错误
	{
		out.print("<script>alert(\"验证码输入错误！\");</script>");
	}	
	else
	{
		String username = request.getParameter("username");//获取提交数据
		String password = request.getParameter("password");
		String password2 = request.getParameter("password2");
		if(!username.equals(""))//空值判断   
		{
			if(!password.equals(""))//其实可以用JS做 但是我都写好了 
			{
				if(password.equals(password2))
				{
					util sql = new util();
					sql.begin();
					Session hsession = sql.getSession(); //hibernate初始化
					hsession.beginTransaction();  
					List query= hsession.createSQLQuery("select * from user where username = '"+username+"'").addEntity(user.class).list();;
					Iterator rs = query.iterator();
					
					java.util.Date date= new java.util.Date();//创建一个时间对象，获取到当前的时间
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置时间显示格式
					String nowtime = sdf.format(date);//将当前时间格式化为字符串
					
					if(!rs.hasNext())
					{
						user newuser = new user();  
						newuser.setTime(nowtime);//注册时间
						newuser.setUsername(username);
						newuser.setPassword(password);
						newuser.setIcon("");//头像  
						newuser.setPoint(0);//积分 //好像暂时用不到
						hsession.save(newuser); 
						hsession.getTransaction().commit();   
						hsession.close(); 
						out.print("<script>alert(\"注册成功!\");location.href=\"login.jsp\";</script>");
					}
					else
					{
						out.print("<script>alert(\"用户名已存在！\");</script>");
						hsession.close(); 
					}
				}
				else
				{
					out.print("<script>alert(\"密码输入不一致！\");</script>");
				}
			}
			else
			{
				out.print("<script>alert(\"请输入密码！\");</script>");
			}
		}
		else
		{
			out.print("<script>alert(\"请输入用户名！\");</script>");
		}
		
	}
}
%>
<body>
<form action="#" method="post">
<table width="446" border="0">
  <tr>
    <td width="76">用户名</td>
    <td width="168"><input type="text" name="username" id="username" /></td>
  </tr>
  <tr>
    <td>密码</td>
    <td><input name="password" type="password" id="password" /></td>
  </tr>
    <tr>
    <td>确认密码</td>
    <td><input type="password" name="password2" id="password2" /></td>
  </tr>
    <tr>
    <td>验证码</td>
    <td><input type="text" name="rand" id="rand" /></td>
    <td width="188"><img src="../randCodeImage" /></td>
  </tr>
    <tr>
    <td>&nbsp;</td>
    <td><input type="submit" name="button" id="button" value="注册" /></td>
  </tr>
</table>
</form>
</body>
</html>