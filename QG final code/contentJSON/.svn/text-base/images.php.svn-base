<?php
require('../config.php');
require('images.inc.php');
$folder_list="";
if (count($subdirs)>0){
 $folder_list='"'.implode('","',$subdirs).'"';
}
$json='{ folders:['.$folder_list.'], count:'.count($imgs).'}';
header('X-JSON: '.$json);
?>
<?php
if (count($imgs)>0){
  foreach ($imgs as $i => $value){
    $full_img=implode('/',array($path,$value));
?>
<div class='img_tile'>
  <img border='0'
     src="<?php echo $img_pre_path.$full_img ?>.thumb.jpg"
     onclick="showCloseup('<?php echo $img_pre_path.$full_img ?>.jpg')"/>
  <br/>
  <?php echo $value ?>
  </a>
</div>
<?php
  }
}
?>
