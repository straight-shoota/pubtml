/**
 * Pubtml Module: Listings
 *
 * @file pubtml/listings
 * @require pubtml
 */

Pubtml.Listings = {
  createListings: function(){
    var figureListings = [];
    var tableListings = [];
    $('figure').each(function(){
      var id = $(this).attr('id');
      if(id == undefined){
        id = Pubtml.makeId(this);
      }
      listing = '<dt><a href="#' + id + '"><span>'+ $(this).attr('id') + '</span></a></dt><dd>' + $(this).find('figcaption').text() + '</dd>'
      if($(this).hasClass('table')){
        tableListings.push(listing);
      }else{
        figureListings.push(listing);
      }
    })
    $('#abbildungsverzeichnis').after('<dl>' + figureListings.join('') + '</dl>');
    $('#tabellenverzeichnis').after('<dl>' + tableListings.join('') + '</dl>');
  }
}
Pubtml.task("createListings", Pubtml.Listings.createListings)
