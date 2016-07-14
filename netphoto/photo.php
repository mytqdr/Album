<?php
session_start();
include'mysql.php';
$sql = "select username,path,photo.Id,info,auz,uperid from photo,userinfo where userinfo.Id=photo.uperid and photo.Id = ".$_GET["id"]; 
$result = mysql_query($sql);
$row = mysql_fetch_array($result);
if(!$row)
{
	echo "<script> alert('照片信息错误！'); </script>"; 
	echo "<meta http-equiv='Refresh' content='0;URL=index.php'>"; 
	exit;
}
else
{
	if($row['auz']==1&&$_SESSION["userid"]!=$row['uperid'])
	{
		echo "<script>alert('照片信息错误！');history.go(-1);</script>";
		exit;  
	}
}
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
.top {
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
    <td height="491" colspan="3" valign="top" bgcolor="#3598DB">
    <table width="923" height="491" border="0">

      <tr>
        <td><div align="center">
          <p>
          <?php
		   echo "<img src=\"".$row['path']."\"width=\"".$imgw."\"height=\"".$imgh."\" />";
		   ?>     </p>
            <span class="photo">
            <div align="center">
          <?php
		   echo $row['info'];
		   ?> 
            </p>  
            </span>

   
	<span class="user">
            
            
            上传者：
          <?php
		   echo $row['username'];
		   ?> </p>                                  </td>
      </tr>   </span> </table><table width="923" height="120" border="0"><td width="300"></td>
      <td align="center">
      <?php 
	  	$sqllike = "select * from likeinfo where userid=".$_SESSION["userid"]." and picid = ".$_GET["id"]; 
		$resultlike = mysql_query($sqllike);
		if(mysql_num_rows($resultlike))
		{
			echo "<form method=\"POST\" action=\"like.php\">
      		<input type=\"submit\" name=\"type\" id=\"type\" value=\"取消收藏\" />
			<input type=\"hidden\" name=\"picid\" value=\"".$_GET["id"]."\" />
			<a href=\"".$row['path']."\" onclick=\"javascript:window.open(url, '_blank ' );\">
			<input type=\"button\"  value=\"下载照片\"/></a>
     		</form>";
		}
		else
		{
			echo "<form method=\"POST\" action=\"like.php\">
      		<input type=\"submit\" name=\"type\" id=\"type\" value=\"收藏照片\" />
			<input type=\"hidden\" name=\"picid\" value=\"".$_GET["id"]."\" />
			<a href=\"".$row['path']."\" onclick=\"javascript:window.open(url, '_blank ' );\">
			<input type=\"button\"  value=\"下载照片\"/></a>
     		</form>";
		}
	  ?>  </td>
<td align="center">
      
   </td> <td width="300"></td>
             </table><table width="923" height="120" border="0">
          <p>&nbsp;
<?php
	$sqlcom = "select username,info,comment.Id,comment.uperid from comment,userinfo where userinfo.Id = comment.uperid and picid = ".$row['Id']; 
	$resultcom = mysql_query($sqlcom);
	if(mysql_num_rows($resultcom))
	{
		while($rowcom = mysql_fetch_array($resultcom))
		{
			echo "<tr>";
			echo "<div align=\"left\"><td width=\"80\">";
			if($rowcom['uperid']==$_SESSION["userid"]||$_SESSION["userid"]==$row['uperid'])
			{
				echo "<a href=\"comdel.php?type=delete&id=".$rowcom['Id']."\" onClick=\"return confirm('确定删除?');\">";
				echo "<input type=\"button\" name=\"type\" id=\"type\" value=\"删除评论\" /></a>";
			}
			echo "</td><td width=\"130\"><span class=\"photo\">";
			echo $rowcom['username'].":</td><td><span class=\"photo\">";
			echo $rowcom['info'];
			echo "</tr> </span> </div>";
		}
	}
	else
	{
		echo "<DIV align=\"center\" valign=\"middle\" class=\"top\" >目前尚未有评论。<BR><BR><BR><BR></DIV>";
	}
  ?>
    <center>
<form method="POST" action="comup.php">
        <textarea name="textarea" id="textarea" cols="30" rows="4">在此处输入评论</textarea>
        <input type="submit" name="type" id="type" value="提交" />
      	<input type="hidden" name="picid" value="
        <?php echo $_GET["id"];?>
        " />
</form>
</center> 
</table>
</body>
</center>
</html>