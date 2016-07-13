<?php
session_start();
if(!isset($_SESSION["username"]))
{
	exit;
}
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
	background-color: #9b58b5;
}
.top {
	font-family: "微软雅黑";
	font-size: 12px;
	color: #FFFFFF;
}
-->
</style>
<table width="80%"  border="0" align="center">
<br><br><br><br>
<form name="form" method="post" action="uploading.php" enctype="multipart/form-data">
<tr>
    <td align="center">
    <span class="top">
    <label for="file">文件:</label>
    <input name="file" type="file" id="file">
    <br><br>
   <textarea name="textarea" id="textarea" cols="30" rows="4">在此处输入照片说明</textarea><br><br></td>
  </tr>
            

     <tr>
    <td align="center"><span class="top">权限设置：<input type="radio" name="auz" value="0"  checked="checked" />公开
                <input type="radio" name="auz" value="1"  />私密<br><br></span><input type="submit" id="type" name="type" value="上传图片"></td>
  </tr>
  </form>
</table>

<body>
</body>
</html>
