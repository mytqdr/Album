<?php
session_start();
include'mysql.php';
$sql = "select uperid from photo where Id = ".$_POST['id']; 
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
		if($_POST["type"] == "修改")
		{
			$sqlup = "update photo set info = '".$_POST["textarea"]."' , auz ='".$_POST["auz"]."' where Id =".$_POST["id"];
			if(mysql_query($sqlup))
			{
				echo "<script> alert('修改成功！'); </script>"; 
				echo "<meta http-equiv='Refresh' content='0;URL=data_pic.php'>"; 
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
						