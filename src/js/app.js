$(function() {

  var cues = {
    curtain: 7 * 1000,
    voice: 20 * 1000,
    marquee: 22 * 1000,
    cats: 24 * 1000
  };

  function curtain() {
    console.log('curtain');
    $('#curtain').fadeOut('slow');
  }

  function voice() {
    console.log('voice');
    var audioElement = document.getElementById("welcomeVader");
    audioElement.playbackRate = 0.5;
    audioElement.play();
  }

  function marquee() {
    $('marquee#welcome').css('display', 'block');
  }

  function cats() {
    console.log('meow!');
    $('.leftcat').animate({ left: "0px", bottom: "0px"}, 30 * 1000)
      $('.ritecat').animate({ right: "0px", bottom: "0px"}, 30 * 1000)
  }

  setTimeout(curtain, cues.curtain);
  setTimeout(voice, cues.voice);
  setTimeout(marquee, cues.marquee);
  setTimeout(cats, cues.cats);
});

