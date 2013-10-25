<?php
/*
The first part of this file describes various file system paths and URLs for the
system. Read Chapter D of the book if you're not sure what they mean, but basically:

$basedir       base dir of image repository being browsed by QG
               must be writeable by the web server user account (usually 'nobody')
               must be mounted by the web server too
$slides_dir    world-writeable directory into which slideshow data is stored (v2.0 only)
$img_pre_path  append this to the URL to fetch an image from the web server

Note that my name (dave) appears in several configs, because, surprisingly, that's
my user account name on most of my machines. Feel free to change it to your own user account
if you don't want to change your name, I'll understand :-)

Dave Crane
September 2006
*/

/* uncomment for standard Linux setup
$basedir='/home/dave/sites/album/images';
$slides_dir='/home/dave/sites/album/slides';
$img_pre_path='/dave/album/images';
*/

/* uncomment for standard Mac setup
$basedir='/Users/dave/Sites/album/images';
$slides_dir='/Users/dave/Sites/album/slides';
$img_pre_path='/dave/album/images';
*/

/* uncomment for standard Windows XAMPP setup */
//$basedir='c:/Program Files/xampp/htdocs/album/images';
//$slides_dir='c:/Program Files/xampp/htdocs/album/slides';
$basedir='c:/dev/xampp/htdocs/album/images';
$slides_dir='c:/dev/xampp/htdocs/album/slides';
$img_pre_path='/album/images';
/* */


$thumb_max=120;
/** end of configuration */

?>