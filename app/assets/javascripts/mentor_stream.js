(function() {
  var recorderManager;
  var recorder;
  var player;
  var recImgData;
  var questionID;

  var API_KEY = '16288541';
  var TOKEN = 'moderator_token';

  var VIDEO_HEIGHT = 240;
  var VIDEO_WIDTH = 320;


  $(document).ready(function() {
      // $.ajaxSetup({
      //   beforeSend: function(xhr) {
      //     xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
      //   }
      // });
      // 
      // $('.respondButton').click(function() { respond(this) } );
      // recorderManager = TB.initRecorderManager(API_KEY);
      // createRecorder();
  });

  var respond = function(t) {
      $('#responseModal').reveal();
      questionID = $(t).eq(0).parents('.mentorItem').data('id');
  }

  function createRecorder() {
      var recDiv = document.createElement('div');
      recDiv.setAttribute('id', 'recorderElement');
      document.getElementById('recorderContainer').appendChild(recDiv);
      recorder = recorderManager.displayRecorder(TOKEN, recDiv.id);
      recorder.addEventListener('recordingStarted', recStartedHandler);
      recorder.addEventListener('archiveSaved', archiveSavedHandler);
  }

  function getImg(imgData) {
      var img = document.createElement('img');
      img.setAttribute('src', imgData);
      return img;
  }

  function loadArchiveInPlayer(archiveId) {
      if (!player) {
  	playerDiv = document.createElement('div');
  	playerDiv.setAttribute('id', 'playerElement');
  	document.getElementById('playerContainer').appendChild(playerDiv);
  	player = recorderManager.displayPlayer(archiveId, TOKEN, playerDiv.id);
  	document.getElementById('playerContainer').style.display = 'block';
      } else {
  	player.loadArchive(archiveId);
      }
  }


  //--------------------------------------
  //  OPENTOK EVENT HANDLERS
  //--------------------------------------

  function recStartedHandler(event) {
      recImgData = recorder.getImgData();
  }

  function archiveSavedHandler(event) {
      $.post('/messages',
          {
  	        csrf: $('meta[name="csrf-token"]').attr('content'),
  	        value: event.archives[0].archiveId,
       	    data_type: 'video',
  	        conversation_id: questionID,
  	        new_conversation: true
          },
          function(data) {
  	        $('.close-reveal-modal').trigger('click');
  	        window.location = '/mentors/' + current_user + '/conversations?conversation_id=' + questionID;
      	}
    	);
  }

  function archiveLoadedHandler(event) {
      archive = event.archives[0];
      archive.startPlayback();
  }
});