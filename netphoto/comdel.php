<?php
session_start();
include'mysql.php';
if(!isset($_SESSION["username"]))
{
	echo "<script> alert('请先登录！'); </script>"; 
	echo "<meta http-equiv='Refresh' content='0;URL=login.php'>"; 
	exit;
}
$sql = "select picid,comment.uperid as cid,photo.uperid as pid from comment,photo where photo.Id=comment.picid and comment.Id = ".$_GET['id']; 
$result = mysql_query($sql);
$row = mysql_fetch_array($result);
if(!$row)
{
	echo "<script>alert('评论不存在！');history.go(-1);</script>";  
	exit;
}
else
	{
	if($_SESSION["userid"]==$row['cid']||$_SESSION["userid"]==$row['pid'])
	{
		if($_GET["type"] == "delete")
		{
			$sqldel="delete from comment where comment.Id = ".$_GET['id'];
			if(mysql_query($sqldel))
			{
				unlink($row['path']);
				echo "<script>alert('删除成功！');history.go(-1);</script>";
				exit;
			}
			else
			{
				echo "<script>alert('数据库繁忙！'); history.go(-1);</script>";
				exit;
			}
		}
		else
		{
			echo "<script>alert('提交错误！');history.go(-1);</script>";  
			exit;
		}
	}
	else
	{
		echo "<script>alert('你没有权限修改这张照片！');history.go(-1);</script>";
		exit;
	}
}
?>