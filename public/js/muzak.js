  var notes = [];
  var n = 16;
  var steps = 16;
  var step = (2.4/steps)*1000;

  for(var i=0,ii=n; i<ii; i++) {
    notes[i] = [];
    for(var j=0,jj=steps;j<jj; j++) {
      var audio = new Audio();
      audio.src = "Samples/"+(i+1)+".wav";
      audio.addEventListener('ended', function() {
          this.currentTime = 0;
          this.play();
      }, false);
      
      notes[i][j] = audio;
    }
  }
  //var text  = "Hello my name is jim "
  //var text2 = "And this is my bassline"


var stopnotes = function() {
  _.each(notes, function(e,i) {
    _.each(e, function(n,i) {
      n.pause();
      n.currentTime = 0;
    });
  });
};

var play_sequence = function(text, text2) {
  var sequence = [];
  var playnotes = function(pos) {
    var length = sequence[pos].length;
    for(var i=0,ii=length;i<ii;i++) {
      var n=sequence[pos][i];
      notes[n][pos].play();
    }
  };
  for(var i=0,ii=16;i<ii;i++) {
    sequence[i] = [];

    if(text[i].match(/[A-z]/)) {
      if(i%3 == 0) {
        sequence[i].push(text.charCodeAt(i) % 12);
      }

    }
    if(text2[i].match(/[A-z]/))
      sequence[i].push((text2.charCodeAt(i) % 4) + 12);
  }

  setTimeout(function() {
      playnotes(0);
  }, 0);
  setTimeout(function() {
      playnotes(1);
  }, 1*step);
  setTimeout(function() {
      playnotes(2);
  }, 2*step);
  setTimeout(function() {
      playnotes(3);
  }, 3*step);
  setTimeout(function() {
      playnotes(4);
  }, 4*step);
  setTimeout(function() {
      playnotes(5);
  }, 5*step);
  setTimeout(function() {
      playnotes(6);
  }, 6*step);
  setTimeout(function() {
      playnotes(7);
  }, 7*step);
  setTimeout(function() {
      playnotes(8);
  }, 8*step);
  setTimeout(function() {
      playnotes(9);
  }, 9*step);
  setTimeout(function() {
      playnotes(10);
  }, 10*step);
  setTimeout(function() {
      playnotes(11);
  }, 11*step);
  setTimeout(function() {
      playnotes(12);
  }, 12*step);
  setTimeout(function() {
      playnotes(13);
  }, 13*step);
  setTimeout(function() {
      playnotes(14);
  }, 14*step);
  setTimeout(function() {
      playnotes(15);
      }, 15*step);
};
