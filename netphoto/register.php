<?php
session_start();
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>照你大爷——您的照片管理专家！</title>
<style type="text/css">
<!--
body {
	background-image: url(images/background.jpg);
	background-position: center 0;
background-repeat: no-repeat;
background-attachment:fixed;
background-size: cover; 
}
.STYLE10 {
	font-family: "微软雅黑";
	font-size: 20px;
	color: #FFFFFF;
}.top {
	font-family: "微软雅黑";
	font-size: 22px;
	color: #FFFFFF;
}
-->
</style></head>
<center>
<body  algin="center">
<table width="924" border="0" cellpadding="0" cellspacing="0">
  <tr>
  <td width="138" height="110" align="center" valign="middle">
<?php
	if(isset($_SESSION["username"]))
	{
	echo"
	<div  style=\"background:url(images/main/M0.jpg) no-repeat;width:122px;height:100px;middle \"/>
	<span class=\"top\"> 
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;
欢迎回来<br>"
	.$_SESSION["username"].
	"</span>";
	}
     ?>
</td>
    <td width="920" height="110" align="left" valign="top"><a href="index.php"><img src="images/main/M1.jpg" width="122" height="100" /></a>
        <a href="register.php"><img src="images/main/M2.jpg" width="122" height="100" /></a>
         <?php    if(isset($_SESSION["username"])){ 
		echo"
        <a href=\"logout.php\"><img src=\"images/main/M3_0.jpg\" width=\"122\" height=\"100\" /></a>
        ";}
		else
		{
		echo"
        <a href=\"login.php\"><img src=\"images/main/M3.jpg\" width=\"122\" height=\"100\" /></a>
		";}
        ?>
        <a href="data.php"><img src="images/main/M4.jpg" width="122" height="100" /></a>
      <a href="seach.php"><img src="images/main/M5.jpg" width="122" height="100" /></a></td>
    <td width="7">&nbsp;</td>
    <td width="7">&nbsp;</td>
  </tr>
  
  
  
  <tr>
    <td height="490" colspan="7" valign="top" bgcolor="#F1C40F">&nbsp;
      <p>&nbsp;</p>
      <form action="regcheck.php" method="post">
        <table align="center">
          <tr valign="baseline">
            <td height="41" align="right" nowrap="nowrap" class="STYLE10">用户名:</td>
            <td><input type="text" name="username" value="" size="32" />
            </td>
          </tr>
          <tr valign="baseline">
            <td height="39" align="right" nowrap="nowrap" class="STYLE10">密码:</td>
            <td><input type="password" name="password" value="" size="32" />
              </td>
              
          </tr>
                    <tr valign="baseline">
            <td height="39" align="right" nowrap="nowrap" class="STYLE10">确认密码:</td>
            <td><input type="password" name="password1" value="" size="32" />
              </td>
              
          </tr>
          <tr valign="baseline">
            <td height="44" align="right" nowrap="nowrap" class="STYLE10">密保问题:</td>
            <td><input type="text" name="question" value="" size="32" />
              </td>
          </tr>
          <tr valign="baseline">
            <td height="46" align="right" nowrap="nowrap"><span class="STYLE10">密保问题答案:</span></td>
            <td><input type="text" name="answer" value="" size="32" />
            </td>
          </tr>
          <tr valign="baseline">
            <td nowrap="nowrap" align="right">&nbsp;</td>
            <td><input type="submit" value="注册" />
            </td>
          </tr>
        </table>
        <input type="hidden" name="type" value="register" />
      </form>
      <p>&nbsp;</p></td>
    </tr>
</table>
</body>
</center>
</html>
