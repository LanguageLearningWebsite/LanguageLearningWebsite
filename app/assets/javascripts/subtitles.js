$.expr[':'].textEquals = $.expr.createPseudo(function(arg) {
    return function( elem ) {
        return $(elem).text().toLowerCase().match(`^${arg.toLowerCase()}$`);
    };
});

function setHeight() {
  $("#transcript").css({'height':(($("#video-content").height()-160)+'px')});
  $(".transcript-body").css({'height':(($("#video-content").height()-210)+'px')});
}

function updateCaption(id, captionLanguage, placeHolder) {
  videojs(id, {}, function () {
    let tracks = this.textTracks();
    let metadataTrack;
    let disp = document.getElementById(placeHolder);

    for (let i = 0; i < tracks.length; i++) {
      let track = tracks[i];

      // find the metadata track that's labeled ads
      if (track.kind === 'captions' && track.label === captionLanguage) {
        track.mode = 'showing';
        track.mode = 'hidden';
        // store it for usage outside of the loop
        metadataTrack = track;
      }
    }

    metadataTrack.addEventListener('cuechange', function () {
      let myTrack = this;             // track element is "this"
      let myCues = myTrack.activeCues;      // activeCues is an array of current cues.
      if (myCues.length > 0) {
        disp.innerText = myCues[0].text;
        disp.innerHTML = disp.innerHTML.replace(/\b(\w+?)\b(?![^<]*>)/g, '<span class="word">$1</span>');
      } else {
        disp.innerHTML = "";
        dict.innerHTML = "";
      }
    });

    window.addEventListener('resize', function() {
      setHeight();
    }, true);

    // Set up any options.
    let options = {
      showTitle: false,
      showTrackSelector: true,
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
        setHeight();
        $('#transcript').toggle();
      }
    });

    videojs.registerComponent('MyButton', MyButton);
    let controlBar = this.getChild('controlBar');
    let myButtonInstance = controlBar.addChild('myButton', {}, 14);
    myButtonInstance.addClass("vjs-transcript-toggle-button");
    myButtonInstance.el().setAttribute("title", "Transcript");
  });
}
