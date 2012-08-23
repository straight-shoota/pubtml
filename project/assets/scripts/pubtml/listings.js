/**
 * Pubtml Module: Listings
 *
 * @file pubtml/listings
 * @require pubtml
 */

Pubtml.Listings = {
  createListings: function(){
    var listings = {'figure': [], 'table': [], 'example': []}
    $('figure').each(function(){
      $this = $(this);
      var id = $this.attr('id');
      var useid = true;
      if(id == undefined){
        id = Pubtml.makeId($this);
        useid = false;
      }
      type = 'figure';
      for(t in listings){
        if($this.hasClass(t)){
          type = t;
        }
      }
      listing = '<dt><a href="#' + id + '" class="' + type + '"ref><span>'+ (useid ? $this.attr('id') : '') + '</span></a></dt><dd>' + $this.find('figcaption').html() + '</dd>'

      listings[type].push(listing);
    });
    for(type in listings){
      $('#' + type + 'listings').append('<dl class="listings ' + type + 'listings">' + listings[type].join('') + '</dl>');
    }
  }
}
Pubtml.task("createListings", Pubtml.Listings.createListings)
