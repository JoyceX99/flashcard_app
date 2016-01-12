$(document).on('ready', function(){

  $(document).on('page:change', function() {
    setIndexContainerWidth();
  });

  $(document).on('mouseenter', '.decks li', function() {
    $(this).animate({
      height: '+=10px',
      width: '+=16px',

      marginTop:'-=5px',
      marginBottom:'-=5px',
      marginLeft:'-=8px',
      marginRight:'-=8px',

      paddingTop:'+=5px',
      paddingBottom:'+=5px',
      paddingLeft:'+=8px',
      paddingRight:'+=8px'
    }, 180);
  });

  $(document).on('mouseleave', '.decks li', function() {
    $(this).animate({
      height: '-=10px',
      width: '-=16px',

      marginTop:'+=5px',
      marginBottom:'+=5px',
      marginLeft:'+=8px',
      marginRight:'+=8px',

      paddingTop:'-=5px',
      paddingBottom:'-=5px',
      paddingLeft:'-=8px',
      paddingRight:'-=8px'
    }, 180);
  });


  $(document).on('click', '.decks li, .signin-button, .browse-cards-button', function() {
    window.location = $(this).find('a').attr('href');
		return false;
	});
});

$(window).on('resize', function(){
   setIndexContainerWidth();
});

function setIndexContainerWidth() {
  var containerWidth = $('.decks').outerWidth(true);
  var cardWidth = $('.decks li').outerWidth(true);
  var cardsPerRow = Math.floor(containerWidth/cardWidth);
  var newPadding = Math.floor((containerWidth - Math.floor(containerWidth/cardWidth)*cardWidth - 10*cardsPerRow)/2);
  $('.decks').css({'padding-left':newPadding, 'padding-right':newPadding});
}
