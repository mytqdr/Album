<?php
session_start();
if(!isset($_SESSION["username"]))
{
	echo "<script> alert('请先登录！'); </script>"; 
	echo "<meta http-equiv='Refresh' content='0;URL=login.php'>"; 
	exit;
}
include'mysql.php';
if(isset($_POST["type"]) && $_POST["type"] == "上传图片")
	if ($_FILES["file"]["error"] > 0)
	{
		echo "<script>alert('文件上传出错！错误代码 " . $_FILES["file"]["error"] . "'); history.go(-1);</script>";
		exit;
	}
	else
	{		
		if ($_FILES["file"]["type"] == "image/gif")
		{
			$filetype = ".gif";
		}
		else if($_FILES["file"]["type"] == "image/jpeg")
		{
			$filetype = ".jpg";
		}
		else if($_FILES["file"]["type"] == "image/png")
		{
			$filetype = ".png";
		}
		else if($_FILES["file"]["type"] == "image/pjpeg")
		{
			$filetype = ".jpg";
		}
		else
		{
			$filetype = "other";
		}
		if($_FILES["file"]["size"] < 100000000)
		{
			if($filetype == "other")
			{
				echo "<script>alert('文件类型错误！'); history.go(-1);</script>";
				exit;
			}
			else
			{
				$_FILES['tmp_name'] = realpath($_FILES['tmp_name']); 
				$filepath = "images/user/".date("20ymdhis")."-".rand(1000,9999).$filetype;
				if(move_uploaded_file($_FILES["file"]["tmp_name"],$filepath))
				{
					include'mysql.php';
					$sql = "insert into photo (uperid,path,info,auz) 
					values('".$_SESSION["userid"]."','".$filepath."','".$_POST["textarea"]."','".$_POST["auz"]."')";  
					if(mysql_query($sql))
					{
						echo "<script> alert('上传成功！'); </script>"; 
						echo "<meta http-equiv='Refresh' content='0;URL=data_pic.php'>"; 
						exit;
					}
					else
					{
						unlink($filepath);
						echo "<script>alert('数据库繁忙！'); history.go(-1);</script>";
						exit;
					}
				}
				else
				{
					echo "<script> alert('文件写入失败！'); </script>"; 
					echo "<meta http-equiv='Refresh' content='0;URL=data_pic.php'>"; 
					exit;
				}
			}
		}
		else
		{
			echo "<script>alert('文件大于100Mb！'); history.go(-1);</script>";
			exit;
		}
	}
else
{
	echo "<script>alert('提交失败！'); history.go(-1);</script>";
	exit; 
}
?>