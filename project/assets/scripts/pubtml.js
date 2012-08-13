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
