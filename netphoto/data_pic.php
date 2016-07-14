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
	background-color: #3598DB;
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
$sql = "select path,Id,info,auz from photo where uperid = ".$_SESSION["userid"]; 
$result = mysql_query($sql);
$num = mysql_num_rows($result);
if(!$num)
{
	echo "<DIV align=\"center\" valign=\"middle\" class=\"top\" ><BR><BR><BR><BR><BR><BR>目前没有任何照片。</DIV>";
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
		echo "<form action=\"data_picedt.php\" method=\"get\">
			<a href=\"data_picedt.php?type=edit&id=".$row['Id']."\" onclick=\"javascript:window.open(this.href,'_self');\">
			<input type=\"button\"  value=\"修改照片\"/></a>
			&nbsp;";
    	echo "
		<a href=\"data_picdel.php?type=delete&id=".$row['Id']."\" onClick=\"return confirm('确定删除?');\">
		<input type=\"button\" value=\"删除照片\"/></a>
			</form>&nbsp;";
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
