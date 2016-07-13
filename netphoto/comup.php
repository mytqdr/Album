<?php
session_start();
if(!isset($_SESSION["username"]))
{
	echo "<script> alert('请先登录！'); </script>"; 
	echo "<meta http-equiv='Refresh' content='0;URL=login.php'>"; 
	exit;
}
if(isset($_POST["type"]) && $_POST["type"] == "提交")
{
	include'mysql.php';
	$sql_insert = "insert into comment (uperid,picid,info) values('".$_SESSION["userid"]."',".$_POST["picid"].",'".$_POST["textarea"]."')"; 
	if(mysql_query($sql_insert))  
    {  
		echo "<script>alert('评论成功！'); history.go(-1);</script>"; 
		exit;
    }  
    else  
    {  
        echo "<script>alert('系统繁忙！'); history.go(-1);</script>";  
		exit;
    }  
}
else
{
	 echo "<script>alert('提交失败！'); history.go(-1);</script>";  
	 exit;
}
?>