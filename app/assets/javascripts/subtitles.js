$.expr[':'].textEquals = $.expr.createPseudo(function(arg) {
    return function( elem ) {
        return $(elem).text().toLowerCase().match("^"+arg.toLowerCase()+"$");
    };
});

function updateTranscript(id) {
  let player = videojs(id);
  player.on('loadedmetadata', function(){
    // Set up any options.
    let options = {
      showTitle: false,
      showTrackSelector: false,
    };

    // Initialize the plugin.
    let transcript = this.transcript(options);

    // Then attach the widget to the page.
    let transcriptContainer = document.querySelector('#transcript');
    transcriptContainer.appendChild(transcript.el());

    $('#transcript').hide();

    var Button = videojs.getComponent('Button');
    var MyButton = videojs.extend(Button, {
      constructor: function() {
        Button.apply(this, arguments);
        /* initialize your button */
      },
      handleClick: function() {
        /* do something on click */
        $('#transcript').toggle();
        $('.video-container').toggleClass('width-100');
        $('.video-container').toggleClass('width-70');
        $('.subtitle-display').toggleClass('width-100');
        $('.subtitle-display').toggleClass('width-70');
      }
    });
    videojs.registerComponent('MyButton', MyButton);
    let controlBar = this.getChild('controlBar');
    let myButtonInstance = controlBar.addChild('myButton', {}, 14);
    myButtonInstance.addClass("vjs-transcript-toggle-button");
    myButtonInstance.el().setAttribute("title", "Transcript");
  });
}

function updateCaptionLine(metadataTrack, disp) {
  let myCues = metadataTrack.activeCues;      // activeCues is an array of current cues.
  let text;
  if (myCues && myCues[0]) {
    text = myCues[0].text;
    if (metadataTrack.label === 'simplified-characters') {
      disp.innerHTML = text.replace(/[\u4e00-\u9fa5]+/g, '<span class="word">$&</span>');
    } else {
      disp.innerHTML = text.replace(/\b(\w+?)\b(?![^<]*>)/g, '<span class="word">$1</span>');
    }
    $('.word').click(function (e) {
      $('.word.active').removeClass('active');
      let word = e.target.innerText.toLowerCase();
      $(".word:textEquals("+word+")").addClass('active');

      $.ajax({
        url: '/api/v1/translate?',
        type: 'GET',
        async: true,
        dataType: 'json',
        data: {
          phrase: word,
        },
        'crossDomain': true,
        'success': function (data) {
          $('#dictionary').empty();
          if (data.length === 0) {
            $('#dictionary').append("Unable to look up the word!");
          } else {
            $('#dictionary').append("<h5>Simplified: " + data[0].simplified + "</h5>");
            $('#dictionary').append("<h5>Traditional: " + data[0].traditional + "</h5>");
            $('#dictionary').append("<ol id='definitionList'></ol>");
            let i = 0;
            for (; i < data.length; i++) {
              pronunciation = "<b>Pronunciation:</b> " + data[i].pronunciation
              definition = "<br><b>Definition:</b> " + data[i].definitions
              $("#definitionList").append("<li>" + pronunciation + definition + "</li>");
            };
          }
        }
      });
    });
  } else {
    disp.innerHTML = "";
  }
}

function updateCaption(id, captionLanguage, placeHolder) {
  let player = videojs(id);
  player.on('loadedmetadata', function() {
    let tracks = this.textTracks();
    let metadataTrack;
    let disp = document.getElementById(placeHolder);

    for (let i = 0; i < tracks.length; i++) {
      let track = tracks[i];
      if (track.kind === 'captions' && track.label === captionLanguage) {
        metadataTrack = track;
      };
      track.mode = 'hidden';
    };

    if (captionLanguage !== 'English') {
      tracks.addEventListener('change', function() {
        for (let i = 0; i < tracks.length; i++) {
          let track = tracks[i];
          if (track.kind === 'captions' && track.mode === 'showing') {
            metadataTrack = track;
          }
          track.mode = 'hidden';
        }
        updateCaptionLine(metadataTrack, disp)
      });
    }

    metadataTrack.addEventListener('cuechange', function() {
      updateCaptionLine(metadataTrack, disp)
    });
  });
}
