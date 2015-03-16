<?php 

$image='abc.jpg';
$img=GetimageSize($image);

//print_r($img);

switch($img[2])
{
	case 1:$im=@ImageCreatFromGIF($image);
	break;
	case 2:$im=@ImageCreatFromJPEG($image);
	break;
	case 3:$im=@ImageCreatFromPNG($image);
	break;
	
}

$loge='11.jpg';
$img1=GetimageSize($loge);
switch($img1[2])
{
	case 1:$im=@ImageCreatFromGIF($loge);
	break;
	case 2:$im=@ImageCreatFromJPEG($loge);
	break;
	case 3:$im=@ImageCreatFromPNG($loge);
	break;
	
}

imagecopy($im,$img1,400,30,10,0,'100','100');


$te = imagecolorallocate($im,255,255,255);
$str = iconv("gbk","UTF-8","新年快乐");//确定要绘制的中文文字

imagettftext($im,12,0,20,20,$te,'mmd.ttf',$str);



//输出图像

//header("Content-type: image/jpeg");
//if(ImageJpeg($im,'新图片.jpg')){
//	echo "yes";
//}

$new=InageCreateTrueColor (500,500);
ImageCopyResised($new,$im,0,0,0,0,30,30,800,600,$img[0],$img[1]);

header("Content-type: image/jpeg");
ImageJpeg($im);



?>