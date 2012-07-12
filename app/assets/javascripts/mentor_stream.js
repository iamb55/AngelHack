Stream = function() {
  var questionID;

  this.init = function() {
    $.ajaxSetup({
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
      }
    });

    $('.respondButton').click(function() { stream.respond(this) } );
  }

  this.respond = function(t) {
      $('#responseModal').reveal();
      tokbox.createRecorder(stream.archiveSavedHandler);
      questionID = $(t).parents('.mentorItem').data('id');
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
      	player = tokbox.recorderManager.displayPlayer(archiveId, OPENTOK_TOKEN, playerDiv.id);
      	document.getElementById('playerContainer').style.display = 'block';
      } else {
      	player.loadArchive(archiveId);
      }
  }

  this.archiveSavedHandler = function(event) {
      console.log('test');
      $.post('/messages',
          {
  	        video: event.archives[0].archiveId,
       	    data_type: 'video',
  	        conversation_id: questionID,
  	        new_conversation: true
          },
          function(data) {
  	        $('.close-reveal-modal').trigger('click');
  	        window.location = '/mentors/conversations?conversation_id=' + questionID;
      	}
    	);
  }
}

var stream = new Stream();

Loader.register(function() {
  stream.init();
});




