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

List query= hsession.createSQLQuery("select id,title,time from news order by news.time desc LIMIT 5").list();
Iterator rs = query.iterator();
//查询前五条的标题 ID 时间
%>
<body>
<table width="304" border="0">
  <tr>
    <td width="235"><strong>公告</strong></td>
    <td width="59">&nbsp;</td>
  </tr>
  
  
<%
while(rs.hasNext())//获取帖子查询结果
{
	Object[] rnews=(Object[])rs.next();//传值给变量
	int rnid=(int)rnews[0];//返回的ID
    String rntitle=(String)rnews[1];
	String rntime=(String)rnews[2];
	
	String title = "";
	if(rntitle.length()>=13)
	{
		title=rntitle.substring(0,13)+"..";
	}
	else
	{
		title=rntitle;
	}
	
	out.print("<tr><td><a href=\"news.jsp?id="+rnid+"\">"+title+"</a></td><td>"+rntime.substring(5,10)+"</td></tr>");
	}
%>
    
  
  
</table>
</body>
</html>