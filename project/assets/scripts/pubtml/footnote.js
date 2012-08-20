/**
 * Pubtml Module: Footnote
 *
 * @file pubtml/Footnote
 * @require jquery, pubtml
 */

Pubtml.Footnote = {
  externalLinks: function(){
    $('a:not([href^="#"]):not(.here)').not('sup a, .footnote a').each(function(){
      var $this = $(this);
      var href = $this.attr('href');

      if ($this.text() == href
        || new RegExp("((https?:)?\/\/)?"+$this.text()).exec(href)){
        // this link shall be shown in the text
        $this.addClass('here');
        return;
      }

      var title = $this.attr('title');
      if(title == undefined){
        title = $this.html();
      }
      var link = '<a href="' + href + '">' + title + '</a>'
      $this.append(Pubtml.Footnote.createFootnote(link));
      $this.replaceWith($this.html());
    });
    if(Pubtml.PRINT) Log.info('js: replaced external links with footnotes');
  },
  createFootnote: function(content) {
    return $('<span class="footnote">' + content + '</span>');
  }
}

Pubtml.task("externalLinksAsFootnotes", Pubtml.Footnote.externalLinks)
