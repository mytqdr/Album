<?php
session_start();
include'mysql.php';
$sql = "select path,uperid from photo where Id = ".$_GET['id']; 
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
		if($_GET["type"] == "delete")
		{
			$sqldel="delete from photo where Id = ".$_GET['id'];
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
}
?>