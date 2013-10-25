<?php
require('../config.php');
require('slideshows.inc.php');

$allHeaders=apache_request_headers();
$slideName=$allHeaders['X-SLIDENAME'];
$postBody=$HTTP_RAW_POST_DATA;
if ($slideName!=null && $postBody!=null){
  $filename=$basedir.'/../slides/'.$slideName.'.slides';
  $filehandle=fopen($filename,'w');
  fwrite($filehandle,$postBody);
  fclose($filehandle);
}

$slideshows=list_slideshows();
if (count($slideshows)>0){
  $slideshow_list='"'.implode('","',$slideshows).'"';
}
$json='{ action:\'save\', slideshows:['.$slideshow_list.'] }';
header('X-JSON: '.$json);
?>
