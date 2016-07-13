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
	background-color: #eb6100;
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
$sql = "select path,photo.Id,info,auz from photo,likeinfo where photo.Id=likeinfo.picid and userid =  ".$_SESSION["userid"]; 
$result = mysql_query($sql);
$num = mysql_num_rows($result);
if(!$num)
{
	echo "<DIV align=\"center\" valign=\"middle\" class=\"top\" ><BR><BR><BR><BR><BR><BR>目前没有收藏的照片。</DIV>";
}
else
{
	echo "<table border=\"0\">";
	$pnum = 0;
	while($row = mysql_fetch_array($result))
	{
		$imginfo=getimagesize($row['path']);
		$imgw = $imginfo[0];
		$imgh = $imginfo[1];
		if($imgh>600)
		{
		 $map = 600/$imgh;
		 $imgh = 600;
		 $imgw = $imgw*$map;
		}
		if($imgw>800)
		{
		 $map = 800/$imgw;
		 $imgw = 800;
		 $imgh = $imgh*$map;
		}
		if($pnum == 0)
		{
			echo "<tr>";
		}
		echo "<td width=\"300\" height=\"300\" ><div align=\"center\">";
		echo "<a href=\"photo.php?id=".$row['Id']."\"target=\"_blank\"><img src=\"".$row['path']."\"width=\"".$imgw."\"height=\"".$imgh."\" /></a>";
		echo "<form method=\"POST\" action=\"like.php\">
      	<input type=\"submit\" name=\"type\" id=\"type\" value=\"取消收藏\" />
		<input type=\"hidden\" name=\"picid\" value=\"".$row['Id']."\" />
		<a href=\"".$row['path']."\" onclick=\"javascript:window.open(url, '_blank ' );\">
		<input type=\"button\"  value=\"下载照片\"/></a>
     	</form>";
		echo "</p></div><span class=\"photo\"><div align=\"center\">".$row['info']."</p></span><span class=\"user\">";
		if($pnum == 1)
		{
			echo "</tr>";
			$pnum = 0;
		}
		else
		{
			$pnum = 1;
		}
	}
	echo "</table>";

}
?>
         
</body>
</html>
