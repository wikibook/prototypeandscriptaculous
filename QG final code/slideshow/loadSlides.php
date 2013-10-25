<?php
require('../config.php');

$allHeaders=apache_request_headers();
$slideName=$_REQUEST['slideName'];
if ($slideName!=null){
  $filename=$basedir.'/../slides/'.$slideName.'.slides';
  if (file_exists($filename)){
    $filehandle=fopen($filename,'r');
    while (!feof($filehandle)) {
      echo fgets($filehandle);
    }
    fclose($filehandle);
  }
}
?>
