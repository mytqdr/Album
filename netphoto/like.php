<?php
session_start();
if(!isset($_SESSION["username"]))
{
	echo "<script> alert('请先登录！'); </script>"; 
	echo "<meta http-equiv='Refresh' content='0;URL=login.php'>"; 
	exit;
}
include'mysql.php';
if(isset($_POST["type"]) && $_POST["type"] == "收藏照片")
{
	$sql = "insert into likeinfo (userid,picid) values(".$_SESSION["userid"].",".$_POST["picid"].")";  
	$res_insert = mysql_query($sql);  
	if($sql)  
	{
		echo "<script>alert('收藏成功！');history.go(-1);</script>";  
		exit;
	}
	else
	{
		echo "<script>alert('服务器繁忙！收藏失败！');history.go(-1);</script>"; 
		exit; 
	}
}
else if(isset($_POST["type"]) && $_POST["type"] == "取消收藏")
{
	$sqldel="delete from likeinfo where userid=".$_SESSION["userid"]." and  picid= ".$_POST["picid"];
	$sqldel = mysql_query($sqldel);  
	if($sqldel)  
	{
		echo "<script>alert('取消收藏成功！');history.go(-1);</script>";  
		exit;
	}
	else
	{
		echo "<script>alert('服务器繁忙！取消收藏失败！');history.go(-1);</script>";
		exit;  
	}
}
else
{
	echo "<script>alert('提交错误！');history.go(-1);</script>";  
	exit;
}
?>