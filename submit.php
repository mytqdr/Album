<?php 

session_start();
if($_POST['check']){
	
	if($_POST['check']==$_SESSION['check_pic']){
		echo"��֤����ȷ".$_SESSION['check_pic'];
	}else{
		echo"��֤�����".$_SESSION['check_pic'];
	}

}

?>

<form action="" method="post">
<img src='che.php'><br>
<input type="text" name="check"><br>
<input type="submit" value="�ύ"><br>
