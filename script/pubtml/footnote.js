/**
 * Pubtml Module: Footnote
 *
 * @file pubtml/Footnote
 * @require jquery, pubtml
 */

Pubtml.Footnote = {
  externalLinks: function(){
    $("a").not("[href^='#']").not('sup a, .footnote a').replaceWith(function(){
      var $this = $(this);
      var link = '<a href="' + $this.attr('href') + '">' + $this.attr('href') + '</a>'
      var title = $this.attr('title');
      if(title == undefined){
        title = $this.html();
      }
      title += ": ";
      $this.append(Pubtml.Footnote.createFootnote(title + link));
      return $this.html();
    });
    if(Pubtml.PRINT) Log.info('js: replaced external links with footnotes');
  },
  createFootnote: function(content) {
    return $('<sup>' + content + '</sup>');
  }
}

Pubtml.task("externalLinksAsFootnotes", Pubtml.Footnote.externalLinks)
