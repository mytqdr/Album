<?php
session_start();
if(!isset($_SESSION["username"]))
{
	exit;
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<style type="text/css">
<!--
body {
	background-color: #E84C3D;
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

<body>
<?php
include'mysql.php';
	$sqlcom = "select username,info,comment.Id,comment.uperid from comment,userinfo where userinfo.Id = comment.uperid and uperid = ".$_SESSION["userid"]; 
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
         
</body>
</html>
