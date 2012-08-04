(function($){
var Pubtml = {};

Pubtml.externalLinks = function(){
  $("a").not("[href^='#']").not('sup a, .footnote a').replaceWith(function(){
    var $this = $(this);
    var link = '<a href="' + $this.attr('href') + '">' + $this.attr('href') + '</a>'
    var title = $this.attr('title');
    if(title == undefined){
      title = $this.html();
    }
    title += ": ";
    $this.append(Pubtml.makeFootnote(title + link));
    return $this.html();
  });
  if(isPrince) Log.info('js: replaced external links with footnotes');
}
Pubtml.makeFootnote = function(content) {
  return $('<sup>' + content + '</sup>');
}

$(document).ready(function(){
  var isPrince = window.Prince !== undefined;
  $('body').addClass(isPrince ? 'prince print' : 'browser web');

  if(isPrince){
    for(i in Prince){
      Log.info(i + ": ");
      Log.info(Prince[i]);
    }
  }

  Pubtml.externalLinks();
});
window.Pubtml = Pubtml;

})(jQuery);
