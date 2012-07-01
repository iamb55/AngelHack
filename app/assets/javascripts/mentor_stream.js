Stream = function() {
  var questionID;

  var API_KEY = '16288541',
      TOKEN = 'moderator_token',
      VIDEO_HEIGHT = 240,
      VIDEO_WIDTH = 320;

  this.init = function() {
    $.ajaxSetup({
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
      }
    });

    $('.respondButton').click(function() { stream.respond(this) } );

    stream.createRecorder();
  }

  this.respond = function(t) {
      $('#responseModal').reveal();
      questionID = $(t).eq(0).parents('.mentorItem').data('id');
  }

  this.createRecorder = function() {
      var recDiv = document.createElement('div');
      recDiv.setAttribute('id', 'recorderElement');
      document.getElementById('recorderContainer').appendChild(recDiv);
      recorder = tokbox.recorderManager.displayRecorder(TOKEN, recDiv.id);
      recorder.addEventListener('recordingStarted', function(e) {
        tokbox.recStartedHandler(e, recorder)
      });
      recorder.addEventListener('archiveSaved', stream.archiveSavedHandler);
  }

  this.getImg = function(imgData) {
      var img = document.createElement('img');
      img.setAttribute('src', imgData);
      return img;
  }

  this.loadArchiveInPlayer = function(archiveId) {
      if (!player) {
      	playerDiv = document.createElement('div');
      	playerDiv.setAttribute('id', 'playerElement');
      	document.getElementById('playerContainer').appendChild(playerDiv);
      	player = tokbox.recorderManager.displayPlayer(archiveId, TOKEN, playerDiv.id);
      	document.getElementById('playerContainer').style.display = 'block';
      } else {
      	player.loadArchive(archiveId);
      }
  }

  this.archiveSavedHandler = function(event) {
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
}

var stream = new Stream();

Loader.register(function() {
  stream.init();
});




