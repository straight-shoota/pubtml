Pubtml.Glossary = {
  createGlossary : function() {
    glossary = [];

    // Find glossary items
    $('abbr').filter(function(i) {
      if ($(this).hasClass('noglossary'))
        return false;
      return true;
    }).each(function(k,v) {
      dg = $(this).first().attr("title");
      if (dg) {
        txt = $(this).first().text();
        glossary.push([txt,dg]);
        $(this).addClass("inglossary");
      }
    });

    // Sort glossary by abbrevation
    glossary.sort(function(a,b) {
      x = a[0];
      y = b[0];
      return x < y ? -1 : (x > y ? 1 : 0);
    });

    // And insert
    $('#glossary').each(function(i) {
      $(this).append("<dl></dl>");
      root = $(this).children().filter('dl');
      $.each(glossary, function(k,v) {
        root.append("<dt>"+v[0]+"<dd>"+v[1]);
      });
    });
  }
}
