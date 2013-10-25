<?php
require('../config.php');
require('thumbnail.inc.php');
$basename=$_REQUEST['name'];
$path=$_REQUEST['path'];
$size=$_REQUEST['size'];


ensure_thumbnail($basename,$path,$size);

?>
<h1>done</h1>
