$(document).ready(function() {
// Once a link is chosen, randomly change the position of the whole_note div.

  $('.letter_link_class').on('click', function(event){

    event.preventDefault();

    var currentPosition = $("#whole_note").css("bottom")
    var letterChosen = $(this).html();

    var request1 = $.ajax({
      url: "/game/guess",
      type: "get",
      data: {letter: letterChosen, currentPosition: currentPosition}
    })

    request1.done(function(response){

      console.log(response.correct);
      // Reveal whether answer correct

      if (response.correct){
        $("#answer_display").html("That's correct");
      }
      else{
        $("#answer_display").html("Wrong!  Try again.");
      }
      // update position of whole note
      $("#whole_note").css("bottom", response.bottom)


    })





  })

});
