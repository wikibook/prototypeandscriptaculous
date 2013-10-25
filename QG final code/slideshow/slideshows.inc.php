<?php
/*
build up list of saved slideshows
*/
function list_slideshows(){
  global $slides_dir;
  $d=dir($slides_dir);
  $slides=array();
  while (false != ($entry = $d->read())){
    $bits=explode('.',$entry);
    if ($bits[count($bits)-1]=='slides'){
      $slides[]=$bits[0];
    }
  }
  return $slides;
}
?>