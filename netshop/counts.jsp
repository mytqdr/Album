<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="errorPage.jsp"  %>
<script language="javascript" src="/js/jquery-3.1.0.min.js" charset="utf-8"></script>
<%
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
int num = 0;
String id = request.getParameter("id");

if(id == null)
{
	out.print("id is null.");
}
else
{
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/netshop","root","951215");
	stmt = conn.createStatement();
	rs=stmt.executeQuery("select * from system where id ="+id);
	if(rs.next())
	{
		num = rs.getInt("VivewNum");
		num++;
		out.print("此商品已被浏览"+num+"次");
		sql = "UPDATE system SET VivewNum = "+num+" WHERE id = "+id;
		stmt.executeUpdate(sql);
	}
	else
	{
		sql = "insert into system VALUES ('"+id+"','1')";
		stmt.executeUpdate(sql);
		out.print("此商品已被浏览1次");
	}
}
%>