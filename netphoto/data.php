<?php
session_start();
if(!isset($_SESSION["username"]))
{
	echo "<script> alert('请先登录！'); </script>"; 
	echo "<meta http-equiv='Refresh' content='0;URL=login.php'>"; 
	exit;
}
$type= $_GET["type"];
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
.STYLE11 {font-size: 18px}

.top {
	font-family: "微软雅黑";
	font-size: 22px;
	color: #FFFFFF;
}
.user {
	font-family: "微软雅黑";
	font-size: 14px;
	color: #FFFFFF;
}
.photo {
	font-family: "微软雅黑";
	font-size: large;
	color: #FFFFFF;
}
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
	&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;  &nbsp;&nbsp;
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
    <td height="490" colspan="3" align="center" valign="middle"><table width="905" height="446" border="0" align="center">

      <tr>
       <td width="211" align="center" valign="middle" bgcolor="#3598DB" class="top" height="95"><p> <a href="data.php">我的相册</a></p>
          </td>
        <td width="684" rowspan="5"  ><iframe width="684"  height="475" src="
        <?php
		switch($type)
		{
			case upload:
				echo "data_upload.php";
				break;
			case comment:
				echo "data_comment.php";
				break;
			case like:
				echo "data_like.php";
				break;
			case user:
				echo "data_user.php";
				break;
			default:
				echo "data_pic.php";
		}
        ?>
        "></iframe></td>
        </tr>
                  <tr>  
        <td width="211" align="center" valign="middle" bgcolor="#9b58b5" class="top" height="95"><a href="data.php?type=upload">上传照片</a></td>
        </tr>
      <tr>  
        <td width="211" align="center" valign="middle" bgcolor="#E84C3D" class="top" height="95"><a href="data.php?type=comment">我的评论</a></td>
        </tr>
      <tr>  
        <td width="211" align="center" valign="middle" bgcolor="#eb6100" class="top" height="95"><a href="data.php?type=like">我的收藏</a></td>
        </tr>
      <tr>  
        <td width="211" align="center" valign="middle" bgcolor="#F1C40F" class="top" height="95"><a href="data.php?type=user">密码修改</a></td>
        </tr>


    </table></td>
    </tr>
</table>
</body>
</center>
</html>