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

Pubtml.makeId = function(elem){
  var name = $(elem).text().toLowerCase().replace(/[^a-z0-9_]+/g, '-').replace(/[-_]+/g, '-').replace(/^-+|-+$/g, '')
  if(name.length > 0){
    if($('#' + name).length == 0){
      //check if id is not already taken
      id = name;
    }else{
      id = name + "-" + Pubtml.hash(5);
    }
  }else{
    id = Pubtml.hash(5);
  }
  $(elem).attr('id', id);
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
