/*
JavaScript code for the slideshow functionality in the QuickGallery app

TODO
move the slide name onto rhs area at top, let it update
trash can to record and cancel multiple pulsates
debug on IE

Dave Crane aug 2006
*/
Event.observe(
  window,
  'load',
  function(){
    $('newSlideshow').onclick=function(){
      SlideShow.create('slides');
    }
    $('saveSlideshow').onclick=function(){
      SlideShow.saveSlides();
    }
    $('runSlideshow').onclick=function(){
      SlideShow.show();
    }
    $('SlideshowName').onblur=function(){
      SlideShow.name=this.value;
    }
  }
);

Ajax.Responders.register(
  {
    onComplete:function(request,transport,json){
      if (json && json.slideshows){
        SlideShow.showSlideshows(json.slideshows);
      }
    }
  }
);

var SlideShow={

  create:function(el,name,htmlContent){
    this.body=$(el);
    this.name=name;
    this.initUI(htmlContent);
    Ajax.Responders.register(
      {
        onComplete:function(request,transport,json){
          if (json && 'folder'==json.action){
            this.initDragDrop();
          }
        }.bind(this)
      }
    );
  },

  initUI:function(htmlContent){
    this.body.innerHTML='';
    Element.removeClassName(this.body,"hidden");
    Element.removeClassName('trash',"hidden");
    Element.removeClassName('SlideshowName',"hidden");
    Element.hide('closeup');
    Element.show('images');
    Element.setStyle(
      'images',
      { width: "396px" }
    );
    if (htmlContent){
      this.loadContent(htmlContent);
    }
    this.initDragDrop();
    if (this.name && this.name.length>0){
      $('SlideshowName').value=this.name;
    }else{
      new Effect.Pulsate(
        'SlideshowName',
        {
          duration: 2,
          beforeStart:function(){
            $('SlideshowName').value='please provide a name';
          },
          afterFinish:function(){
            var txtBox=$('SlideshowName');
            txtBox.value='';
            txtBox.focus();
          }
        }
      );
    }
  },

  initDragDrop:function(){
    /*create the thumbnails list as a sortable, allowing elements to be dragged from it
      note that only the slideshow strip is droppable 
    */
    Sortable.create(
      'images',
      {
        tag: "div",
        containment:[this.body],
        constraint: false,
        ghosting: true,
        onChange:function(el){
          _debug("images onChange("+el.id+")");
        },
        onUpdate:function(el){
          _debug("images onUpdate("+el.id+")");
        }
      }
    );
    /*set the slideshow strip as a simple droppable object, for receiving thumbnails*/
    Droppables.add(
      this.body,
      {
        onDrop:function(tile,target){
          if (tile.className=="slide"){ return; }
          _debug("slides onDrop("+tile.id+","+target.id+")");
          this.createSlide(tile,target);

        }.bind(this)
      }
    );

    Droppables.add(
      'trash',
      {
        onDrop:function(tile,target){
          if (tile.className=="slide"){
            _debug("trash onDrop("+tile.id+","+target.id+")");
            tile.remove();
            if (this.trashEffect){
              this.trashEffect.cancel();
            }
            this.trashEffect=new Effect.Pulsate(target);
          }

        }.bind(this)
      }
    );

  },

  loadContent:function(htmlContent){
    this.body.innerHTML='';
    var tmpDiv=Builder.node("div");
    tmpDiv.innerHTML=htmlContent;
    tmpDiv.cleanWhitespace();
    $A(tmpDiv.childNodes).each(
      function(node){
        this.createSlide(node,this.body);
      }.bind(this)
    );
  },

  createSlide:function(tile,target){
    var newSlide=Builder.node("div", { className: "slide" } );
    newSlide.innerHTML=tile.innerHTML;
    target.appendChild(newSlide);
    var img=newSlide.getElementsByTagName("img")[0];
    img.onclick=null;
    var caption=newSlide.getElementsByTagName("p")[0];
    newSlide.fullSrc=img.src.replace("120","420");
    newSlide.slideId=caption.firstChild.data;
    new Ajax.InPlaceEditor(
      caption,
      "echo.php",
      { 
        rows:3, 
        cols:36,
        submitOnBlur: true,
        okButton: false
      }
    );
    //notify server to create image
    new Ajax.Request(
      "thumbnail.php",
      {
        parameters: $H(
          {name: newSlide.slideId,path:currPath,size:"420"}
        ).toQueryString()
      }
    );
    /* refresh the sortable to allow drag-drop rearrangement of images within the slideshow*/
    Sortable.create(
      this.body,
      {
        tag: "div",
        containment:[this.body,'trash'],
        handle:'img',
        constraint: 'vertical',
        scroll: true
      }
    );
    this.body.scrollTop=this.body.scrollHeight;

  },

  showSlideshows:function(slideshows){
    if (slideshows.length==0){
      Element.hide("slideshows");
    }else{
      Element.show("slideshows");
      $("slideshows").innerHTML=slideshows.collect(
        function(slideshow){
          return "<div onclick='SlideShow.loadSlides(\""+slideshow+"\")'>"+slideshow+"</div>";
        }
      ).join("");
    }
  },

  loadSlides:function(slideName){
    new Ajax.Request(
      "loadSlides.php",
      {
        postBody: $H({slideName:slideName}).toQueryString(),
        onComplete:function(response){
          this.create('slides',slideName,response.responseText);
        }.bind(this)
      }
    );
  },

  saveSlides:function(){
    var snapshot=$('slides').innerHTML;
    new Ajax.Request(
      "saveSlides.php",
      {
        method: "post",
        contentType: "text/html",
        requestHeaders: ["X-SLIDENAME",this.name],
        postBody: snapshot
      }
    );
  },

  show:function(){
    _debug("show()");
    this.slideData=$A($("slides").childNodes).collect(
      function(node){
        var imgSrc=node.fullSrc;
        var caption=node.getElementsByTagName("p")[0].firstChild.data;
        _debug("--"+node.slideId+", "+imgSrc);
        return { imgSrc: imgSrc, caption: caption };
      }
    );
    this.slideData.loadCount=0;
    this.slideData.liveCount=0;
    this.showBackdrop();
    //preload the slides themselves
    this.slideData.each(
      function(slide){
        slide.loaded=false;
        slide.image=new Image(); 
        slide.image.src=slide.imgSrc;
        slide.image.onload=function(){
           _debug("success loading "+slide.imgSrc); 
           this.slideLoaded(slide); 
        }.bind(this); 
        slide.image.onerror=function(){ _debug("error loading "+this.imgSrc); }.bind(slide);
        slide.div=Builder.node("div", { src: slide.imgSrc, className: "liveslide" } );
        slide.div.innerHTML=
          "<img src='"
          +slide.imgSrc
          +"' class='liveImage'/>"
          +"<br/>"
          +"<p class='liveCaption'>"
          +slide.caption
          +"</p>";
      }.bind(this)
    );
  },

  slideLoaded:function(slide){
    _debug("loaded "+slide.imgSrc);
    slide.loaded=true;
    this.slideData.loadCount++;
    this.showBackdrop();
    if (this.slideData.loadCount==this.slideData.length){
      this.effect=new Effect.SlideShow(
        "liveSlides",
        this.slideData.pluck("div")
      );
    }
  },

  showBackdrop:function(){
    Element.removeClassName("backdrop","hidden");
    if (this.slideData.loadCount<this.slideData.length){
      $('backdrop').innerHTML='loading: '+this.slideData.loadCount+' of '+this.slideData.length;
    }else{
      $('backdrop').innerHTML='loaded';
      $('stopShow').onclick=function(){
        if (this.effect){
          this.effect.cancel();
        }
        Element.addClassName("liveSlides","hidden");
        Element.addClassName("backdrop","hidden");
      }.bindAsEventListener(this);
    }
  }

};


Effect.SlideShow = Class.create();
Object.extend(Object.extend(Effect.SlideShow.prototype, Effect.Base.prototype), {

  currentSlide: null,

  initialize: function(element,slides,opts) {
    this.element = $(element);
    var slideTools=$('slideTools');
    this.element.innerHTML="";
    this.element.appendChild(slideTools);
    Element.removeClassName(this.element,"hidden");
    this.slides=slides;
    var interval=(opts && opts.interval) ? opts.interval : 3;
    var options=Object.extend(
      {
         transition: Effect.Transitions.linear,
         duration: slides.length*interval,
         fps: (1/3)
      },
      opts || {}
    );
    this.start(options);
  },

  update: function(position) {
    _debug("update("+position+")");
    var oldSlide=this.currentSlide;
    var len=this.slides.length;
    var index=Math.floor(position*len);
    if (index==len){ index=len-1; } //if position=1.0 exactly
    this.currentSlide=this.slides[index];
    _debug("currentSlide = "+index);
    if (this.currentSlide!=oldSlide){ 
      if (oldSlide){ Element.remove(oldSlide); }
      this.element.appendChild(this.currentSlide);
    }  
  }

});

function _debug(msg){
  new Insertion.Top("debug","<div>"+msg+"</div>");
}