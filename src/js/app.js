$(function() {

  var SECONDS = 1000;
  var cues = {
    cats: 24 * SECONDS,
    curtain: 7 * SECONDS,
    marquee: 22 * SECONDS,
    voice: 20 * SECONDS
  };

  function credits() {
    console.log('credits');
    var names = [
      'Adrienne',
      'Annelie',
      'Antony',
      'Brian',
      'Chas',
      'Cy',
      'Davidad',
      'Hani',
      'Hannah',
      'Kat',
      'Laura B.',
      'Laura D.',
      'Lily',
      'Liz',
      'Polar Bear',
      'Sebastien',
      'Shameer',
      'Siraj',
      'Virgil',
      'Walrus',
    ];

    var timePerName = (cues.marquee - cues.curtain) / names.length;
    for (var i = 0; i < names.length; i++) {
      var delay = i * timePerName;
      queueCredit(names[i], delay);
    }
  }

  function queueCredit(name, delay) {
    setTimeout(function() {
      showCredit(name);
    }, delay);
  }

  // TODO implement animated text credits
  function showCredit(name) {
      console.log(name);
  }

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
  setTimeout(credits, cues.curtain);
  setTimeout(voice, cues.voice);
  setTimeout(marquee, cues.marquee);
  setTimeout(cats, cues.cats);
});

