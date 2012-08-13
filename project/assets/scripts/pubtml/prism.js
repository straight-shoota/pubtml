/* prince throws an error when running prism. so for now its only to use in webrowsers */

Pubtml.task("addPrism", function(){
  if(Pubtml.WEB){
    $.getScript('http://prismjs.com/prism.js', function(){Prism.highlightAll();});
  }
})
