<?php
require('../config.php');
require('thumbnail.inc.php');
require('slideshows.inc.php');



/*
scan through a directory, listing out all the subfolders and image files
*/
function list_dir($dir,$path){
  $dirs=array();
  $imgs=array();
  $others=array();
  $d=dir($dir);
  while (false != ($entry = $d->read())){
    if (is_dir(implode('/',array($dir,$entry)))){
      if (($entry!='.') && ($entry!='..')){
        $dirs[]=$entry;
      }
    }else if (is_image_file($entry,$path)){
      $bits=explode('.',$entry);
      $imgs[]=$bits[0];
    }else{
      $others[]=$entry;
    }
  }
  $results=array(
    'dirs' => $dirs,
    'imgs' => $imgs,
    'others' => $others
  );
  return $results;
}

/*
decide whether a file is an image, based on it's name
*/
function is_image_file($entry,$path){
  global $thumb_max;
  $is_image=false;
  $bits=explode('.',$entry);
  $last=count($bits)-1;
  if ($bits[$last]=='jpg'){
    //ignore the thumbnails we've already made!
    $is_image=($bits[$last-1]!='thumb' && $bits[$last-2]!='thumb');
    if ($is_image){
      ensure_thumbnail($bits[0],$path,$thumb_max);
    }
  }
  return $is_image;
}

/*
build up breadcrumb trail
*/
function get_breadcrumbs($path){
  $bits=split('/',$path);
  $crumbs=array();
  $tmp_path='/';
  $crumbs[]=array(
    'name' => 'home',
    'path' => $tmp_path
  );
  foreach ($bits as $i => $value){
    if (strlen($value) > 0){
      $tmp_path.=$value.'/';
      $crumbs[]=array(
        'name' => $value,
        'path' => $tmp_path
      );
    }
  }
  return $crumbs;
}

/*
work out whether we're giving close-up of image, or view of thumbnails
*/
function is_close_up($name){
  $result=false;
  $bits=explode('.',$name);
  $last=$bits[count($bits)-1];
  if ($last=='jpg'){ $result=true; }
  return $result;
}


if (isset($_GET['path'])){
  $path=$_GET['path'];
  $fulldir=implode('/',array($basedir,$path));
}else{
  $path="";
  $fulldir=$basedir;
}
$crumbs=get_breadcrumbs($path);
$cc=count($crumbs);
if ($cc > 0){
  $closeup=is_close_up($crumbs[$cc-1]['name']);
}else{
  $closeup=false;
}
if ($closeup==false){
  $listings=list_dir($fulldir,$path);
  $subdirs=$listings['dirs'];
  $imgs=$listings['imgs'];
  $others=$listings['others'];
  $slideshows=list_slideshows();
}


?>