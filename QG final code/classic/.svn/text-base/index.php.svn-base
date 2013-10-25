<?php
require('../config.php');
require('images.inc.php');
?>
<html>
<head>
<link rel='stylesheet' type="text/css" href="images.css">
</head>
<body>

<div id='title' class='box'>
<?php foreach ($crumbs as $i => $value){ ?>
  &nbsp;&gt;&nbsp;<a href="index.php?path=<?php echo $value['path'] ?>">
  <?php echo $value['name'] ?>
  </a>
<?php } ?>
</div>

<?php if ($closeup){ ?>

<div id='closeup' class='box'>
<img src='<?php echo $img_pre_path.$path ?>'>
</div>
<?php }else{ ?>

<?php if (count($subdirs)>0){ ?>
<div id='folders' class='box'>
<?php foreach ($subdirs as $i => $value){ ?>
<div>
  <a href="index.php?path=<?php echo implode('/',array($path,$value)) ?>">
    <?php echo $value ?>
  </a>
</div>
<?php } ?>
</div>
<?php } ?>

<?php if (count($imgs)>0){ ?>
<div id='images' class='box'>
<?php foreach ($imgs as $i => $value){
    $full_img=implode('/',array($path,$value));
?>
<div class='img_tile'>
  <a href="index.php?path=<?php echo $full_img ?>.jpg">
  <img border='0' src="<?php echo $img_pre_path.$full_img ?>.thumb.jpg"/></a>
  <br/>
  <?php echo $value ?>
  </a>
</div>
<?php } ?>
</div>
<?php } ?>


<?php } ?>

</body>
</html>