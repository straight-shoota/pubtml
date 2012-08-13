/**
 * Pubtml Module: Footnote
 *
 * @file pubtml/toc
 * @require pubtml, outliner
 */

Pubtml.Toc = {
  createOutline: function(){
    var Toc = function(elem){
      this.depth = 0;
      this.level = 0
      if(elem != null){
        this.level = +elem.tagName.substr(1);
      }
      this.elem = elem;
      this.sectionNumber = []
      this.parent = null;
      this.children = [];
      this.add = function(item){
        this.children.push(item);
        item.depth = this.depth + 1;
        item.parent = this;
        if(! $(this.elem).hasClass('nonumber')){
          item.sectionNumber = this.sectionNumber.slice()
          item.sectionNumber.push(this.children.length)
        }
      }
      this.getSectionNumber = function(){
        return this.sectionNumber.join(".")
      }
      this.walk = function(open, close){
        if(typeof open == "function"){
          //open.bind(this).apply();
          open(this);
        }
        for (var i = 0; i < this.children.length; i++) {
          this.children[i].walk(open, close)
        };
        if(typeof close == "function"){
          //close.bind(this).apply();
          close(this);
        }
      }
    }

    var hash = function(s){
      if (typeof(s) == 'number' && s === parseInt(s, 10)){
        s = Array(s + 1).join('x');
      }
      return s.replace(/[xy]/g, function(c) {
        var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
        return v.toString(16);
      });
    }

    var root = new Toc(null, null);
    var lastItem = root;
    $("h1,h2,h3,h4,h5,h6").not(".notoc").filter(function(){
      return $(this).closest('.titlepage').length == 0
    }).each(function() {
      if($(this).attr('id') == undefined){
        var name = $(this).text().toLowerCase().replace(/[^a-z0-9_]+/g, '-').replace(/[-_]+/g, '-').replace(/^-+|-+$/g, '')
        id = name;
        if($('#'+id).length > 0){
          id = name.length > 0 ? name + "-" + hash(5) : hash(5);
        }
        $(this).attr('id', id);
      }
      var item = new Toc(this);

      while(item.level <= lastItem.level && lastItem.parent != null){
        lastItem = lastItem.parent
      }
      lastItem.add(item)

      $(this).attr('data-section-number', item.getSectionNumber());
      lastItem = item
    });

    console.log(root);
    var html = '<ol class="toc">'
    root.walk(function(toc){
      if(toc.parent == null){
        return;
      }
      html += "<li>";
      html += '<a href="#' + $(toc.elem).attr('id') + '" data-section-number="' + toc.getSectionNumber() + '">' + $(toc.elem).html() + '</a>'
      console.log(new Array(toc.depth).join("  ") + " " + toc.getSectionNumber() + " " + $(toc.elem).text())
      if(toc.children.length > 0){
        html += "<ol>"
      }
    }, function(toc){
      if(toc.parent == null){
        return;
      }
      if(toc.children.length > 0){
        html += "</ol>"
      }
      html += "</li>"
    });
    html += "</ol>"
    //console.log(html)
    $('#toc').append(html)
  },
  createOutline_: function(){
    var html = "<ol>"

    var prevlevel = 1;
    var cnt = Array(0,0,0,0);
    var cntapp = 0;
    var isappendix = false;
    var toc = []
    toc.newItem
    var lastItem = {item: null, children: []}
    $("h1,h2,h3,h4,h5,h6").not(".notoc").each(function() {
      $this = $(this)
      var curlevel = +$this.tagName.substr(1)
      while (curlevel != prevlevel) {
        if (curlevel > prevlevel) {
          html += "<ol>";
          prevlevel += 1;
          cnt[prevlevel] = 0;
        } else {
          html += "</ol>";
          prevlevel -= 1;
        }
      }
      var isappendix = $(this).hasClass("appendix");
      var classstr = ""
      if ($(this).hasClass("nonumber") || curlevel > 3) {
        classstr = " class='nonumber'";
      }
      if (isappendix) {
        classstr = " class='appendix'";
        cntapp += 1;
      } else {
        cnt[curlevel] += 1;
      }
      var tocstr = "toc";
      for (i=0; i<=curlevel; i++) {
        if (isappendix && i == 2)
          tocstr += "_a"+cntapp;
        else
          tocstr += "_"+cnt[i];
      }
      html += "<li"+classstr+"><a href=\"#"+tocstr+"\">"+value.textContent+"</a>";
      links = $(this).children('a').filter(function(i) {
        //console.log($(this));
        name = $(this).first().attr("name")
        //console.log(name);
        if (name == tocstr) {
          return true
        }
        return false;
      });
      //console.log(links);
      if (links.length == 0) {
        $(this).addClass("toclink");
        // do not wrap header tags in div, this messes up css counting
        $(this).html("<a name=\""+tocstr+"\">"+$(this).html()+"</a>");
        //if (setoptions['interactive']) {
          ////$(this).wrapInner("<span class=toclink id=\""+tocstr+"\" />");
          //$(this).html("<div class=toclink id=\""+tocstr+"\">"+$(this).html()+"</div>");
        //} else {
          //$(this).html("<a name=\""+tocstr+"\"></a>"+$(this).html());
        //}
      }
    });

    html += "</ol>"
    return html
  },
  createToc: function(){
    if (typeof HTML5Outline == "undefined"){
      return
    }
    var outline = HTML5Outline(document.body)

    function filterNode(index, node){
      // process sub nodes
      node.sections = $(node.sections).filter(filterNode).toArray()

      //console.log(node.heading)
      // we have: heading, sections, startingNode
      if(typeof node.heading == "string" && node.heading.startsWith("<i>Untitled ")){
        // Untitled Node -> remove it
        return false;
      }
      return true;
    }

    filterNode(0, outline);

    $('#toc').html(outline.asHTML(true))
  }
}
if (typeof String.prototype.startsWith != 'function') {
  String.prototype.startsWith = function (str){
    return this.slice(0, str.length) == str;
  };
}
Pubtml.task("createOutline", Pubtml.Toc.createOutline)
