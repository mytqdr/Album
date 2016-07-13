<?php
session_start();
if(isset($_POST["type"]) && $_POST["type"] == "登录")
{
	include'mysql.php';
	$sql = "select username from userinfo where username = '".$_POST[username]."'"; 
	$result = mysql_query($sql);
	$num = mysql_num_rows($result);
	if($num)
	{  
		    $logsql = "select Id,username from userinfo where username = '".$_POST[username]."' and password = '".$_POST[password]."'";
	        $logresult = mysql_query($logsql);  
            $lognum = mysql_num_rows($logresult);  
            if($lognum)  
            {  
                $row = mysql_fetch_array($logresult);  
                $_SESSION["username"]=$row['username'];  
				$_SESSION["userid"]=$row['Id'];
				echo "<script> alert('欢迎回来，".$_SESSION["username"]."！'); </script>"; 
				echo "<meta http-equiv='Refresh' content='0;URL=index.php'>"; 
				exit;
            }  
            else  
            {  
                echo "<script>alert('密码不正确！');history.go(-1);</script>";  
				exit;
            }  
    }  
	else
	{  
   		echo "<script>alert('用户名不存在！'); history.go(-1);</script>";  
		exit;
    } 
}
else
{
	 echo "<script>alert('提交失败！'); history.go(-1);</script>";  
	 exit;
}

?>