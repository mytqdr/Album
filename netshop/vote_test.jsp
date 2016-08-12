<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="errorPage.jsp"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script language="javascript" src="/js/jquery-3.1.0.min.js" charset="utf-8"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<script>
$(document).ready(function(){
	$("button").click(function(){
		 var id = document.getElementById("text").value;
		 var type = document.getElementByname("RadioGroup1").value;
		 $("#return").load("vote.jsp?id="+id+"&type="+type);
	});
});
</script>
</head>

<body>
  <input type="text" name="text" id="text" />
  <p>
    <label>
      <input type="radio" name="RadioGroup1" value="yes" id="RadioGroup1_0" />
      赞成</label>
    <br />
    <label>
      <input type="radio" name="RadioGroup1" value="no" id="RadioGroup1_1" />
      反对</label>
    <br />
  </p>
<button>提交</button>
<p id="return"></p>
</body>
</html>