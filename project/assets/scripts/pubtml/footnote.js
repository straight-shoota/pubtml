/**
 * Pubtml Module: Footnote
 *
 * @file pubtml/Footnote
 * @require jquery, pubtml
 */

Pubtml.Footnote = {
  externalLinks: function(){
    $("a").not("[href^='#']").not('sup a, .footnote a').each(function(){
      var $this = $(this);
      var href = $this.attr('href');
      var link = '<a href="' + href + '">' + href + '</a>'
      var title = $this.attr('title');
      if(title == undefined){
        title = $this.html();
      }
      if ($this.hasClass('here') || title == href || new RegExp("(([a-z]+:)?\/\/)?"+title).exec(href)){
        // this link shall be shown in the text
        $this.addClass('here');
        return;
      }
      title += ": ";
      $this.append(Pubtml.Footnote.createFootnote(title + link));
      $this.replaceWith($this.html());
    });
    if(Pubtml.PRINT) Log.info('js: replaced external links with footnotes');
  },
  createFootnote: function(content) {
    return $('<span class="footnote">' + content + '</span>');
  }
}

Pubtml.task("externalLinksAsFootnotes", Pubtml.Footnote.externalLinks)
