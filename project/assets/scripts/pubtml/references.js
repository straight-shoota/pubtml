Pubtml.References = function(){
  var references = {}

  $('a[href^="#"]').not('.exampleref,.tableref,.sectionref,.figref,.pageref').each(function(){
    var $this = $(this);
    var ref = $this.attr('href');
    var target;
    if(!references[ref]){
      //console.log('running reference ' + ref + '...')
      //target = $(ref)
      target = $(document.getElementById(ref.substr(1)));
      type = target.is(".example") ? "exampleref" :
          target.is("table,.table")      ? "tableref"   :
          target.is("h1,h2,h3,h4,h5,h6") ? "sectionref" :
          target.is("figure,.figure")    ? "figref"     :
          "pageref";
      references[ref] = {
        target: target,
        type: type,
        references: []
      }
    }
    references[ref].references.push($this)
    $this.addClass(references[ref].type);
  })
}

Pubtml.task("references", Pubtml.References)
