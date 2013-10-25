<?php
/* 
make sure the image has a thumbnail 
*/
function ensure_thumbnail($base_name,$path,$size){
  global $basedir;
  $thumb_name=join('/',array($basedir,$path,$base_name.'.thumb.'.$size.'.jpg'));
  if (!file_exists($thumb_name)){
    $source_name=join('/',array($basedir,$path,$base_name.'.jpg'));
    $source_img=imagecreatefromjpeg($source_name);
    $source_x=imageSX($source_img);
    $source_y=imageSY($source_img);
    $thumb_x=($source_x > $source_y) ? 
      $size : 
      $size*($source_x/$source_y);
    $thumb_y=($source_x < $source_y) ? 
      $size : 
      $size*($source_y/$source_x);
    $thumb_img=ImageCreateTrueColor($thumb_x,$thumb_y);
    imagecopyresampled(
      $thumb_img,$source_img,
      0,0,0,0,
      $thumb_x,$thumb_y,
      $source_x,$source_y
    );
    imagejpeg($thumb_img,$thumb_name);
    imagedestroy($source_img);
    imagedestroy($thumb_img);
  }
}
?>