$.expr[':'].textEquals = $.expr.createPseudo(function(arg) {
    return function( elem ) {
        return $(elem).text().toLowerCase().match(`^${arg.toLowerCase()}$`);
    };
});

function setHeight() {
  $("#transcript").css({'height':(($("#video-content").height()-135)+'px')});
  $(".transcript-body").css({'height':(($("#video-content").height()-160)+'px')});
}

function updateCaption(id, captionLanguage, placeHolder) {
  let player = videojs(id);
  let tracks = player.textTracks();
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

  metadataTrack.oncuechange = function () {
    let myTrack = this;             // track element is "this"
    let myCues = myTrack.activeCues;      // activeCues is an array of current cues.
    if (myCues.length > 0) {
      disp.innerText = myCues[0].text;
      disp.innerHTML = disp.innerHTML.replace(/\b(\w+?)\b(?![^<]*>)/g, '<span class="word">$1</span>');
    } else {
      disp.innerHTML = "";
    }
  };

  // Set up any options.
  let options = {
    showTitle: false,
    showTrackSelector: false,
  };

  // Initialize the plugin.
  let transcript = player.transcript(options);

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
      $('#subtitle-display').toggleClass('width-100');
      $('#subtitle-display').toggleClass('width-65');
    }
  });

  if (window.innerWidth <= 768) {
    $('#subtitle-display').insertAfter($('.video-container'))
  } else {
    $('#subtitle-display').insertAfter($('.main-player'))
  }

  window.onresize = function(event) {
    if (window.innerWidth <= 768) {
      $('#subtitle-display').insertAfter($('.video-container'))
    } else {
      $('#subtitle-display').insertAfter($('.main-player'))
    }
  };

  videojs.registerComponent('MyButton', MyButton);
  let controlBar = player.getChild('controlBar');
  let myButtonInstance = controlBar.addChild('myButton', {}, 14);
  myButtonInstance.addClass("vjs-transcript-toggle-button");
  myButtonInstance.el().setAttribute("title", "Transcript");
}
