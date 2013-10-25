var ui={};
var data={};

window.onload=function(){
  ui.title=$('title');
  ui.closeup=$('closeup');
  ui.closeupImg=$('closeup_img');
  ui.folders=$('folders');
  ui.images=$('images');
  Element.hide(ui.closeup,ui.folders);
  load('/');
}

function load(path){
  new Ajax.Request(
    "images.php?path="+path,
    { 
      method: "GET",
      onSuccess: parseAjaxResponse
    }
  );
}

function parseAjaxResponse(transport){
  var response=transport.responseXML;
  var docRoot=response.getElementsByTagName('gallery')[0];
  data.path=docRoot.attributes.getNamedItem("path").value;
  data.pre=docRoot.attributes.getNamedItem("pre").value;
  data.folders=parseChildNodes(docRoot,"folders","folder");
  data.images=parseChildNodes(docRoot,"images","image");
  showDir();
}

function parseChildNodes(node,parentTag,childTag){
  //improve with prototype arrays later...
  var results=[];
  try{
    var children=$A(node.getElementsByTagName(parentTag)[0].getElementsByTagName(childTag));
    results=children.collect(
      function(value,index){ return value.firstChild.data; }
    );
  }catch(e){
  }
  return results;
}

function showDir(){
  showBreadcrumbs();
  showFolders();
  showThumbnails();
}

function showBreadcrumbs(){
  var crumbHTML=" &gt; <span onclick='load(\"\")'>home</span>";
  var crumbs=data.path.split("/");
  for(var i=0;i<crumbs.length;i++){
    var crumb=crumbs[i];
    if (crumb.length>0){
      var path=subpath(data.path,"/",i);
      crumbHTML+=" &gt; <span onclick='load(\""+path+"\")'>"+crumb+"</span>";
    }
  }
  ui.title.innerHTML=crumbHTML;
}

function subpath(str,delim,ix){
  //detect if arg1 is string or array?
  var all=str.split(delim);
  var some=all.findAll(
    function(v,i){
      //alert("i="+i+", ix="+ix+", v="+v+", result: "+(i<=ix));
      return (i<=ix);
    }
  );
  return some.join(delim);
}

function showFolders(){
  if (data.folders.length==0){
    Element.hide(ui.folders);
  }else{
/*
    var folderHTML="";
    for (var i=0;i<data.folders.length;i++){
      var folder=data.folders[i];
      var path=[data.path,folder].join("/");
      folderHTML+="<div onclick='load(\""+path+"\")'>hjk "+folder+"</div>";
    }
    Element.show(ui.folders);
    ui.folders.innerHTML=folderHTML;
*/
    var links=data.folders.collect(
      function(value,index){
        var path=[data.path,value].join("/");
        return "<div onclick='load(\""+path+"\")'>"+value+"</div>";
      }
    );
    Element.show(ui.folders);
    ui.folders.innerHTML=links.join("");
  }
}

function showThumbnails(){
  Element.hide(ui.closeup);
  if (data.images.length==0){
    Element.hide(ui.images);
  }else{
    var links=data.images.collect(
      function(value,index){
        var imgUrl=data.pre+data.path+"/"+value+".thumb.jpg";
        return "<div class='img_tile'>"
          +"<img onclick='showCloseup(\""
          +value
          +"\")' src='"
          +imgUrl
          +"'/>"
          +"<br/>"
          +value
          +"</div>";
      }
    );
    Element.show(ui.images);
    ui.images.innerHTML=links.join("");
  }
}

function showCloseup(image){
  Element.hide(ui.images);
  Element.show(ui.closeup);
  ui.closeupImg.src=data.pre+data.path+"/"+image+".jpg";
}
