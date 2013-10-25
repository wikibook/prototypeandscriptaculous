var ui={};
var currPath="/";
var updater=null;

window.onload=function(){
  ui.title=$('title');
  ui.closeup=$('closeup');
  ui.closeupImg=$('closeup_img');
  ui.folders=$('folders');
  ui.images=$('images');
  Element.hide(ui.closeup,ui.folders);
  load();
}

function load(newPath){
  if (newPath!=null){ currPath=newPath; }
  if (updater){
    updater.stop();
  }
  updater=new Ajax.PeriodicalUpdater(
    "images",
    "images.php?path="+currPath,
    { 
      method: "GET",
      evalScripts: true,
      frequency: 10,
      onComplete: function(){ 
        Element.hide(ui.closeup);
      }
    }
  );
}

function showBreadcrumbs(){
  var crumbs=currPath.split("/");
  var crumbHTML=" &gt; <span onclick='load(\"/\")'>home</span>";
  for(var i=0;i<crumbs.length;i++){
    var crumb=crumbs[i];
    if (crumb.length>0){
      var path=subpath(currPath,"/",i);
      crumbHTML+=" &gt; <span onclick='load(\""+path+"\")'>"+crumb+"</span>";
    }
  }
  ui.title.innerHTML=crumbHTML;
}

function subpath(str,delim,ix){
  var all=str.split(delim);
  var some=all.findAll(
    function(v,i){
      //alert("i="+i+", ix="+ix+", v="+v+", result: "+(i<=ix));
      return (i<=ix);
    }
  );
  return some.join(delim);
}

function showFolders(folders){
  if (folders.length==0){
    Element.hide(ui.folders);
  }else{
    var folderHTML="";
    for (var i=0;i<folders.length;i++){
      var folder=folders[i];
      var path=(currPath=="/") ? "/"+folder : [currPath,folder].join("/");
      folderHTML+="<div onclick='load(\""+path+"\")'>"+folder+"</div>";
    }
    Element.show(ui.folders);
    ui.folders.innerHTML=folderHTML;
  }
}


function showCloseup(imgSrc){
  Element.hide(ui.images);
  Element.show(ui.closeup);
  ui.closeupImg.src=imgSrc;
}
