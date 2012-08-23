Pubtml.Glossary = {
  createGlossary : function() {
    var Glossary = function(){
      this.terms = [];
      this.map = {}
    }
    $.extend(Glossary.prototype, {
      add: function(term, desc){
        if(! this.map[term] || this.map[term] !== desc){
          this.terms.push([term, desc]);
        }
      },
      sort: function(){
        this.terms.sort(function(a,b) {
          x = a[0];
          y = b[0];
          return x < y ? -1 : (x > y ? 1 : 0);
        })
      }
    })
    var glossary = Pubtml.Glossary.Glossary = new Glossary();

    // Find glossary items
    $('abbr:not(.noglossary)[title]').each(function(k,v) {
      glossary.add($(this).text(), $(this).attr('title'));
      $(this).addClass("inglossary");
    });

    // Sort glossary by abbrevation
    glossary.sort()

    // And insert
    $('#glossary').each(function(i) {
      $(this).append("<dl></dl>");
      var root = $(this).children().filter('dl');
      $.each(glossary.terms, function(k,v) {
        root.append("<dt>"+v[0]+"</dt><dd>"+v[1] +"</dd>");
      });
    });
  }
}
Pubtml.task("createGlossary", Pubtml.Glossary.createGlossary)
