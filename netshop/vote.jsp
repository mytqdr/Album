<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="errorPage.jsp" import="net.votes"%>
<script language="javascript" src="/js/jquery-3.1.0.min.js" charset="utf-8"></script>
<script language="javascript" src="/js/echarts.min.js" charset="utf-8"></script>
<html style="height: 100%">
   <head>
       <meta charset="utf-8">
   </head>
   <%
String id = request.getParameter("id");
String type = request.getParameter("type");
double y = 0;
double n = 0;
double dy = 50;
double dn = 50;
if(id == null)
{
	out.print("id is null");
}
else
{
	votes votes = new votes();
	votes.setId(id);

		votes.execute(type);
	y =votes.getY();
	n =votes.getN();
	dy = y/(y+n)*100;
	dn = n/(y+n)*100;
}
%>
<body style="height: 100%; margin: 0">
<div id="container" style="height: 100%"></div>
<table width="200" border="0" align="center">
  <tr>
    <td><form name="form1" method="post" action="vote.jsp?id=<%=id%>&type=yes">
      <input type="submit" name="button" id="button" value="赞成">
    </form></td>
    <td><form name="form1" method="post" action="vote.jsp?id=<%=id%>&type=no">
      <input type="submit" name="button" id="button" value="反对">
    </form></td>
  </tr>
</table>

<script type="text/javascript">
var dom = document.getElementById("container");
var myChart = echarts.init(dom);var app = {};
option = null;
option = {
	title : {
        text: '<%=id%>号投票器',
        x:'center'
    },
	    tooltip : {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },
    series : [
        {
            name: '',
            type: 'pie',
            radius: '55%',
            data:[
                {value:<%=y%>, name:'赞同'},
                {value:<%=n%> , name:'反对'}
            ]
        }
    ]
};;
if (option && typeof option === "object") {
    myChart.setOption(option, true);
}
       </script>
      
</body>
</html>