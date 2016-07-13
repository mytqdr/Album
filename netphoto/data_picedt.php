<?php
session_start();
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
</head>
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
</style>
<?php
include'mysql.php';
$sql = "select auz,info,path,uperid from photo where Id = ".$_GET['id']; 
$result = mysql_query($sql);
$row = mysql_fetch_array($result);
if(!$row)
{
	echo "<script>alert('照片不存在！');history.go(-1);</script>";  
	exit;
}
else
{
	if($_SESSION["userid"]!=$row['uperid'])
	{
		echo "<script>alert('你没有权限修改这张照片！');history.go(-1);</script>"; 
		exit; 
	}
	else
	{
		if($_GET["type"] != "edit")
		{
			echo "<script>alert('提交错误！');history.go(-1);</script>";  
			exit;
		}
	}
}

?>

<body><div align="center">
<?php 
$imginfo=getimagesize($row['path']);
$imgw = $imginfo[0];
$imgh = $imginfo[1];
if($imgh>300)
{
	$map = 300/$imgh;
	$imgh = 300;
	$imgw = $imgw*$map;
}
	if($imgw>300)
{
	$map = 300/$imgw;
	$imgw = 300;
	$imgh = $imgh*$map;
}
echo "<img src=\"".$row['path']."\" width=\"".$imgw."\"height=\"".$imgh."\" />"

?>
<form name="form" method="POST" action="data_detcheck.php"><br><br>
<textarea name="textarea" id="textarea" cols="30" rows="4"><?php echo $row['info']; ?></textarea><br><br>
<span class="top">权限设置
<input type="radio" name="auz" value="0" 
<?php 
if($row['auz']==0)
{
	echo "checked=\"checked\"";
}
?> />
公开
<input type="radio" name="auz" value="1"  
<?php 
if($row['auz']==1)
{
	echo "checked=\"checked\"";
}
?>/>
私密<br><br></span>
<input type="submit" name="type" value="修改">
<input type="hidden" name="id" value="
<?php 
	echo $_GET['id'];
?>
" />
</form>
</div></body>
</html>