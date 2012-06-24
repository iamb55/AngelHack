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
  $.ajaxSetup({
    beforeSend: function(xhr) {
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
    }
  });
  
  console.log(getParameterByName('conversation_id'));
  if(getParameterByName('conversation_id')) {
    var el = $("[data-id='" + getParameterByName('conversation_id') + "']");
    changeConversation(el[0]);
  }
  
  $('.user').on('click', function() { changeConversation(this) } );
  $('.text').on('click', respond);
  
  $('.replybar textarea').keypress(function(e) {
    if (e.keyCode == 13 && !e.shiftKey) {
      e.preventDefault();
      respond();
    }
  });
  
  $('.video').click(respondVideo);
  
  recorderManager = TB.initRecorderManager(API_KEY);
  
  createRecorder();

  processVideos();
  

  


});



function respond() {
  reply = $('.replybar textarea').val();
  conversation_id = $('.messages').data().id;
  $.post('/messages', 
        { 
          conversation_id: conversation_id, 
          data_type: 'text', 
          value: reply,
          csrf: $('meta[name="csrf-token"]').attr('content')
        },
        function(data) {
          $('.replybar textarea').val('');
          var m = createMessage(data);
          $('.messages ul').append(m);
          m.fadeIn(1000, function() {
            var myDiv = document.getElementById('scroll');
            myDiv.scrollTop = myDiv.scrollHeight + 200;
          });
        }
  );
}

function changeConversation(t) {
  var _this = $(t);
  $.get('/conversations/' + _this.data().id + ".json",
      function(response) {
        var new_messages = []
        var messages = $('.messages ul');
        response.forEach(function(message) {
          var li;
          if (message.data_type === 'text') li = createMessage(message);
          else li = createVideoMessage(message);
          new_messages.push(li);
        });
        var height = $('.messages').height();
        messages.css('height', height).empty();
        new_messages.forEach(function(message) {
          messages.append(message);
          message.fadeIn();
        });
        processVideos();
        var myDiv = document.getElementById('scroll');
        myDiv.scrollTop = myDiv.scrollHeight;
        $('.messages').data('id', _this.data().id)
  }, 'json')
}

function processVideos() {
  videoPlayers = $('.videoPlayer');

  videoPlayers.each(function(player) {
    player = $(videoPlayers[player]);
    console.log(player);
    var id = player.data('id');
    recorderManager.displayPlayer(id, TOKEN, "p" + id);
  });
  
  setTimeout(function() {
    var myDiv = document.getElementById('scroll');
    myDiv.scrollTop = myDiv.scrollHeight + 200;
  }, 500);
}

function formatDate(date) {
    var d = new Date(date);
    var hh = d.getHours();
    var m = d.getMinutes();
    var s = d.getSeconds();
    var dd = "AM";
    var h = hh;
    if (h >= 12) {
        h = hh-12;
        dd = "PM";
    }
    if (h == 0) {
        h = 12;
    }
    m = m<10?"0"+m:m;

    s = s<10?"0"+s:s;



    return h + ":" + m + " " + dd;
}

function createMessage(message) {
  var li = $("<li></li>");
  var m = $("<div class='container_12 " + message.owner_type + "'></div>");
  var img = "<div class='grid_1'><img src='" + message.picture_url + "'/></div>";
  var name = "<div class='grid_5'><h5>" + message.name + "</h5></div>";
  var timestamp = "<div class='grid_2' id='timestamp'>" + formatDate(message.created_at) + "</div>";
  var content = "<div class='message " + message.owner_type + "'><p>" + message.value + "</p></div>";
  m.append(img);
  m.append(name);
  m.append(timestamp);
  li.append(m);
  li.append(content);
  li.hide();
  return li;
}

function createVideoMessage(message) {
  var li = $("<li></li>");
  var m = $("<div class='container_12 " + message.owner_type + "'></div>");
  var img = "<div class='grid_1'><img src='" + message.picture_url + "'/></div>";
  var name = "<div class='grid_5'><h5>" + message.name + "</h5></div>";
  var timestamp = "<div class='grid_2' id='timestamp'>" + formatDate(message.created_at) + "</div>";
  var videoPlayer = $("<div class='videoPlayer' id='" + message.value + "' data-id='" + message.value + "'></div>");
	playerDiv = document.createElement('div');
	playerDiv.setAttribute('id', "p" + message.value);
	videoPlayer.append(playerDiv);
	videoPlayer.css('display', 'block');
  m.append(img);
  m.append(name);
  m.append(timestamp);
  li.append(m);
  li.append(videoPlayer);
  li.hide();
  return li;
}

var respondVideo = function() {
    $('#responseModal').reveal();
    questionID = $('.messages').data('id');
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
	        value: event.archives[0].archiveId,
     	    data_type: 'video',
	        conversation_id: questionID
        },
        function(data) {
          console.log(data);
	        $('.close-reveal-modal').trigger('click');
          var m = createVideoMessage(data);
          $('.messages ul').append(m);
          m.fadeIn(1000, function() {
            player = recorderManager.displayPlayer(data.value, TOKEN, "p" + data.value);
            setTimeout(function() {
              var myDiv = document.getElementById('scroll');
              myDiv.scrollTop = myDiv.scrollHeight + 500;
            }, 500)
          });
    	  }
    );
}

function archiveLoadedHandler(event) {
    archive = event.archives[0];
    archive.startPlayback();
}

function getParameterByName(name)
{
  name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
  var regexS = "[\\?&]" + name + "=([^&#]*)";
  var regex = new RegExp(regexS);
  var results = regex.exec(window.location.search);
  if(results == null)
    return "";
  else
    return decodeURIComponent(results[1].replace(/\+/g, " "));
}



