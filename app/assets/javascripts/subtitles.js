$.expr[':'].textEquals = $.expr.createPseudo(function(arg) {
    return function( elem ) {
        return $(elem).text().toLowerCase().match(`^${arg.toLowerCase()}$`);
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
        $('.video-container').toggleClass('width-65');
        $('.subtitle-display').toggleClass('width-100');
        $('.subtitle-display').toggleClass('width-65');
      }
    });
    videojs.registerComponent('MyButton', MyButton);
    let controlBar = this.getChild('controlBar');
    let myButtonInstance = controlBar.addChild('myButton', {}, 14);
    myButtonInstance.addClass("vjs-transcript-toggle-button");
    myButtonInstance.el().setAttribute("title", "Transcript");
  });
}

function updateCaption(id, captionLanguage, placeHolder) {
  let player = videojs(id);
  player.on('loadedmetadata', function(){
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
          };
          track.mode = 'hidden';
        };
      });
    };

    metadataTrack.addEventListener('cuechange', function() {
      let myTrack = metadataTrack;             // track element is "this"
      let myCues = myTrack.activeCues;      // activeCues is an array of current cues.
      let text;
      if (myCues && myCues[0]) {
        text = myCues[0].text;
        if (metadataTrack.label === 'simplified-characters') {
          disp.innerHTML = text.replace(/\b(\w+?)\b(?![^<]*>)/g, '<span class="word">$1</span>');
        } else {
          disp.innerHTML = text.replace(/\b(\w+?)\b(?![^<]*>)/g, '<span class="word">$1</span>');
        };
        $('.word').click(function (e) {
          $('.word.active').removeClass('active');
          let word = e.target.innerText.toLowerCase();
          console.log(word);
          $(`.word:textEquals(${word})`).addClass('active');

          $.ajax({
            //The URL to process the request
            url: 'https://glosbe.com/gapi/translate?',
            type: 'GET',
            async: true,
            dataType: 'jsonp',   //you may use jsonp for cross origin request
            data: {
              from: 'zho',
              dest: 'eng',
              format: 'json',
              phrase: word,
              pretty: 'true'
            },
            'crossDomain': true,
            // 'success': function(data) {
            //     dict.innerHTML = JSON.stringify(data.tuc[0].meanings);
            // },
            'success': function (data) {
              $('#dictionary').empty();
              $('#dictionary').append("<h2 id='word'>" + word + "</h2>");
              $('#dictionary').append("<ol id='definitionList'></ol>");
              let def = data.tuc[0].meanings;
              let i = 0;
              for (; i < def.length; i++) {
                $("#definitionList").append("<li>" + def[i].text + "</li>");
              };
            }
          });
        });
      } else {
        disp.innerHTML = "";
      };
    });
  });
};
