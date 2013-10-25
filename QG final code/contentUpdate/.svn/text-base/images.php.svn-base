<?php
require('../config.php');
require('images.inc.php');
$folder_list="";
if (count($subdirs)>0){
 $folder_list='"'.implode('","',$subdirs).'"';
}
?>
<script type='text/javascript'>
  showBreadcrumbs();
  showFolders([<?php echo $folder_list ?>]);
  imgCount=<?php echo count($imgs)?>;
  if (imgCount>0){
    Element.show(ui.images);
  }else{
    Element.hide(ui.images);
  }
</script>

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
