<?php
header("Content-type: text/javascript");
require('../config.php');
require('images.inc.php');
?>
{
 path:"<?php echo $path ?>",
 pre: "<?php echo $img_pre_path ?>"
<?php if (count($subdirs)>0){ ?>
 ,folders:["<?php echo join($subdirs,'","'); ?>"]
<?php } ?>
<?php if (count($imgs)>0){ ?>
 ,images:["<?php echo join($imgs,'","'); ?>"]
<?php } ?>
}

