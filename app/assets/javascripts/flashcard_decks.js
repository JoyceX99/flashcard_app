$(document).on('ready page:load', function() {

  $('.flashcard_outer').flip({
    axis: 'x',
    trigger: 'click',
    speed: 300
  });


  $('#darken_container').width($(document).width());
  $('#darken_container').outerHeight($(document).height(), true);

  $(document).on('keyup', function(e) {
    if (e.keyCode == 27) {
      // $('#darken_container').fadeOut('slow', function() {
      //   $(this).removeClass('darken');
      // });
      // $('#darken_container').show().addClass('normal');
      $('#darken_container').removeClass('darken');
      $('#darken_container').addClass('normal');
    }
  });



  var $flashcards = $('#flashcard_slider li').hide();
  var current = 0;
  var $counter = $('#counter');
  var $memorized = $('#memorized');
  var memorizedCount = 0;

  var flipped = false;
  var freeze_animation = false;

  $flashcards.eq(current).show();
  $counter.html('Flashcard: '+(current+1)+'/'+$flashcards.length);
  $memorized.html('Memorized: '+ memorizedCount);

  function unFreeze() {
    freeze_animation = false;
  }

  $(document).on('click', '#prev', function() {
    moveTo(-1);
  });

  $(document).on('click', '#next', function() {
    moveTo(1);
  });

  $(document).on('click', '.flashcard_outer', function() {
     flipped = !flipped;
     console.log(flipped);
  });

  $(document).on('click', '.memorized_button', function() {
    memorizedCount++;
    var removeId = $flashcards.eq(current).attr('id');
    $('#'+removeId).remove();
    current--;
    $flashcards = $('#flashcard_slider li');
    if ($flashcards.length > 0)
      moveTo(1);
    else
      alert('You have memorized the whole deck! Refresh the page to start over.')
  })


  function moveTo(index) {
    if (freeze_animation)
      return false;
    freeze_animation = true;

    var i;
    if (index == -1) { //prev
      i = (current > 0) ? (current - 1) : ($flashcards.length - 1);
    }
    else if (index == 1) { //next
      i = (current < $flashcards.length - 1) ? (current + 1) : 0;
    }

    //transition
    $flashcards.eq(current).fadeOut(200, function() {
      $flashcards.eq(i).fadeIn(400);
      unFreeze();
      //$flashcards.eq(i).flip(false);
    });

    //reset values
    $counter.html('Flashcard: ' + (i+1) + '/' + $flashcards.length);
    $memorized.html('Memorized: '+ memorizedCount);


    current = i;
  }

});
