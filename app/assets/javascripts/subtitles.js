$.expr[':'].textEquals = $.expr.createPseudo(function (arg) {
  return function (elem) {
    return $(elem).text().toLowerCase().match("^" + arg.toLowerCase() + "$");
  };
});

function updateTranscript(id) {
  var player = videojs(id);
  player.on('loadedmetadata', function () {
    // Set up any options.
    var options = {
      showTitle: false,
      showTrackSelector: false
    };

    // Initialize the plugin.
    var transcript = this.transcript(options);

    // Then attach the widget to the page.
    var transcriptContainer = document.querySelector('#transcript');
    transcriptContainer.appendChild(transcript.el());

    $('#transcript').hide();

    var Button = videojs.getComponent('Button');
    var MyButton = videojs.extend(Button, {
      constructor: function constructor() {
        Button.apply(this, arguments);
        /* initialize your button */
      },
      handleClick: function handleClick() {
        /* do something on click */
        $('#transcript').toggle();
        $('.video-container').toggleClass('width-100');
        $('.video-container').toggleClass('width-70');
        $('.subtitle-display').toggleClass('width-100');
        $('.subtitle-display').toggleClass('width-70');
      }
    });
    videojs.registerComponent('MyButton', MyButton);
    var controlBar = this.getChild('controlBar');
    var myButtonInstance = controlBar.addChild('myButton', {}, 14);
    myButtonInstance.addClass("vjs-transcript-toggle-button");
    myButtonInstance.el().setAttribute("title", "Transcript");
  });
}

function updateCaptionLine(metadataTrack, disp) {
  var myCues = metadataTrack.activeCues; // activeCues is an array of current cues.
  var text = void 0;
  if (myCues && myCues[0]) {
    text = myCues[0].text;
    if (metadataTrack.label === 'simplified-characters') {
      disp.innerHTML = text.replace(/[\u4e00-\u9fa5]+/g, '<span class="word">$&</span>');
    } else {
      disp.innerHTML = text.replace(/\b(\w+?)\b(?![^<]*>)/g, '<span class="word">$1</span>');
    }
    $('.word').click(function (e) {
      $('.word.active').removeClass('active');
      var word = e.target.innerText.toLowerCase();
      $(".word:textEquals(" + word + ")").addClass('active');

      $.ajax({
        url: '/api/v1/translate?',
        type: 'GET',
        async: true,
        dataType: 'json',
        data: {
          phrase: word
        },
        'crossDomain': true,
        'success': function success(data) {
          $('#dictionary').empty();
          if (data.length === 0) {
            $('#dictionary').append("Unable to look up the word!");
          } else {
            $('#dictionary').append("<h5>Simplified: " + data[0].simplified + "</h5>");
            $('#dictionary').append("<h5>Traditional: " + data[0].traditional + "</h5>");
            $('#dictionary').append("<ol id='definitionList'></ol>");
            var i = 0;
            for (; i < data.length; i++) {
              pronunciation = "<b>Pronunciation:</b> " + data[i].pronunciation;
              definition = "<br><b>Definition:</b> " + data[i].definitions;
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
  var player = videojs(id);
  player.on('loadedmetadata', function () {
    var tracks = this.textTracks();
    var metadataTrack = void 0;
    var disp = document.getElementById(placeHolder);

    for (var i = 0; i < tracks.length; i++) {
      var track = tracks[i];
      if (track.kind === 'captions' && track.label === captionLanguage) {
        metadataTrack = track;
      };
      track.mode = 'hidden';
    };

    if (captionLanguage !== 'English') {
      tracks.addEventListener('change', function () {
        for (var _i = 0; _i < tracks.length; _i++) {
          var _track = tracks[_i];
          if (_track.kind === 'captions' && _track.mode === 'showing') {
            metadataTrack = _track;
          }
          _track.mode = 'hidden';
        }
        updateCaptionLine(metadataTrack, disp);
      });
    }

    metadataTrack.addEventListener('cuechange', function () {
      updateCaptionLine(metadataTrack, disp);
    });
  });
}
