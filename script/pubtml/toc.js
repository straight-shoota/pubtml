/**
 * Pubtml Module: Footnote
 *
 * @file pubtml/toc
 * @require pubtml, outliner
 */


Pubtml.Toc = {
  createToc: function(){
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
  },
}
if (typeof String.prototype.startsWith != 'function') {
  String.prototype.startsWith = function (str){
    return this.slice(0, str.length) == str;
  };
}
Pubtml.task("toc.createToc", Pubtml.Toc.createToc.bind(Pubtml.Toc))
