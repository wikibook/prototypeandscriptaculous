<?php
require('images.inc.php');
$folder_list="";
if (count($subdirs)>0){
 $folder_list='"'.implode('","',$subdirs).'"';
} 
if (count($slideshows)>0){
  $slideshow_list='"'.implode('","',$slideshows).'"';
}
$json='{ action:\'folder\', folders:['.$folder_list.'], slideshows:['.$slideshow_list.'], count:'.count($imgs).'}';
header('X-JSON: '.$json);


if (count($imgs)>0){
  foreach ($imgs as $i => $value){ 
    $full_img=implode('/',array($path,$value));
?>
<div class='img_tile' id='<?php echo $value ?>'>
  <img border='0' 
     src="<?php echo $img_pre_path.$full_img ?>.thumb.120.jpg" 
     onclick="showCloseup('<?php echo $img_pre_path.$full_img ?>.jpg')"/>
  <br/>  
  <p><?php echo $value ?></p>
  </a>
</div>
<?php 
  }
} 
?>
