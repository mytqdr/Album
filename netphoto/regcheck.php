<?php
if(isset($_POST["type"]) && $_POST["type"] == "register")
{
	    $r_user = $_POST["username"];  
        $r_psw = $_POST["password"];  
        $r_psw1 = $_POST["password1"];
		if($r_user == "" || $r_psw == "" || $r_psw1 == "")
		{
			 echo "<script>alert('请确认信息完整性！'); history.go(-1);</script>";  
			 exit;
		}
		else
		{
			if($r_psw==$r_psw1)
			{
				include'mysql.php';
				$sql = "select username from userinfo where username = '".$_POST["username"]."'"; 
				$result = mysql_query($sql);
				$num = mysql_num_rows($result);
				if($num)
	            {  
                   echo "<script>alert('用户名已存在'); history.go(-1);</script>";  
				   exit;
                }  
				else 
				{  
					$sql_insert = "insert into userinfo (username,password,question,answer) values('".$_POST["username"]."','".$_POST["password"]."','".$_POST["question"]."','".$_POST["answer"]."')";  
                    $res_insert = mysql_query($sql_insert);  
	                if($res_insert)  
                    {  
						echo "<script> alert('注册成功！'); </script>"; 
						echo "<meta http-equiv='Refresh' content='0;URL=login.php'>"; 
						exit;
                    }  
                    else  
                    {  
                        echo "<script>alert('系统繁忙，请稍候！'); history.go(-1);</script>";  
						exit;
                    }  
				}

			}
			else
			{
				echo "<script>alert('两次输入的密码不一致'); history.go(-1);</script>";  
				exit;
			}
			
		}

}
else
{
	 echo "<script>alert('提交失败！'); history.go(-1);</script>";  
}

?>