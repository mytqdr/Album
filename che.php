<?php 
session_start();
for($i=0;$i<4;$i++){
	$rand.=dechex(rand(1,15));
}
$_SESSION['check_pic']=$rand;
$im = imagecreatetruecolor(100, 30);
 
//设置颜色
$bg= imagecolorallocate($im, 0, 0, 0);  //第一次使用调色板
$te= imagecolorallocate($im, 255, 255, 255);

for($i=0;$i<3;$i++){
	
	$te2= imagecolorallocate($im, rand(0,255), rand(0,255), rand(0,255));
	imageline($im,0,rand(0,15),100,rand(0,15),$te2);
}

for($i=0;$i<200;$i++){
	
	imagesetpixel($im, rand()%100,rand()%30,$te2);
}

$str = iconv("gbk","UTF-8","新年快乐");

imagettftext($im,12,0,20,20,$te,'mmd.ttf',$str);







//把字符串写在图像左上角
//imagestring($im,rand(3,6),rand(3,70), rand(1,10),$rand,$te);

//输出图像/

header("Content-type: image/jpeg");  
imagejpeg($im); //输出的格式




?>