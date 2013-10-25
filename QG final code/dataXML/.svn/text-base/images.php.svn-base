<?php
header("Content-type: text/xml; charset=utf-8");
require('../config.php');
require('images.inc.php');
?>
<gallery path="<?php echo $path ?>" pre="<?php echo $img_pre_path ?>">
<?php if (count($subdirs)>0){ ?>
<folders>
<?php foreach ($subdirs as $i => $value){ ?>
<folder><?php echo $value ?></folder>
<?php } ?>
</folders>
<?php } ?>

<?php if (count($imgs)>0){ ?>
<images>
<?php foreach ($imgs as $i => $value){ ?>
<image><?php echo $value ?></image>
<?php } ?>
</images>
<?php } ?>
</gallery>

