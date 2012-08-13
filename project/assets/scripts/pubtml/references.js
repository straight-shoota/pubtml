Pubtml.References = function(){
  var references = {}

  $('a[href^="#"]').each(function(){
    var $this = $(this);
    var ref = $this.attr('href');
    if(typeof references[ref] == "undefined"){
      var target = $(ref).first();
      var type;
      switch(true){
        case target.is(".example"):
          type = "exampleref"
          break
        case target.is("table,.table,figure.table"):
          type = "tableref"
          break;
        case target.is("h1,h2,h3,h4,h5,h6"):
          type = "sectionref"
          break;
        case target.is("figure,.figure"):
          type = "figref"
          break;
        default:
          type = "reference"
      }

      references[ref] = {
        target: target,
        type: type,
        references: []
      }
    }
    references[ref].references.push($this)
    $this.addClass(references[ref].type);
    $this.addClass("pageref");
  })
}

Pubtml.task("references", Pubtml.References)
