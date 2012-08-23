var Pubtml = {
  tasks: [],
  initialize: function(){
    console.log("initializing pubtml.js...");
    $('body').addClass(this.PRINT ? 'print' : 'web');
    for(name in this.tasks){
      console.log("Calling task " + name)
      this.tasks[name]()
    }
  },
  isPrint: function(){
    return window.Prince !== undefined;
  },
  task: function(name, handler){
    //console.log("registered task " + name)
    this.tasks[name] = handler;
  }
};

Pubtml.PRINT = Pubtml.isPrint();
Pubtml.WEB   = ! Pubtml.PRINT

$(document).ready(function(){
  Pubtml.initialize()
});

Pubtml.task("insertTbody", function(){
  $('table:not(:has(tbody,thead,tfoot))').each(function(){
    $(this).wrapInner('<tbody/>')
  })
})

Pubtml.makeId = function(elem, name){
  elem = $(elem)
  if(elem.attr('id')) return; // not touching existing Ids!

  if(!name){
    name = elem.text();
  }
  var id = name.toLowerCase().replace(/[^\w\-]+/g, '-').replace(/[-_]+/g, '-').replace(/^-|-$/g, '')
  if(id.length > 0){
    try{
    if($('#' + id).length != 0){
      //check if id is not already taken
      id += "-" + Pubtml.hash(5);
    }}catch(e){
      console.log("id: ", id)
    }
  }else{
    id = Pubtml.hash(5);
  }
  elem.attr('id', id);
  return id;
}

Pubtml.hash = function(s){
  if (typeof(s) == 'number' && s === parseInt(s, 10)){
    s = Array(s + 1).join('x');
  }
  return s.replace(/[xy]/g, function(c) {
    var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
    return v.toString(16);
  });
}
