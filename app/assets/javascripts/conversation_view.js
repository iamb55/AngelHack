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
  
  
  
  setTimeout(function() {
    var myDiv = document.getElementById('scroll');
    myDiv.scrollTop = myDiv.scrollHeight + 200;
  }, 500);
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
            console.log('test');
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
          var li = createMessage(message);
          new_messages.push(li);
        });
        var height = $('.messages').height();
        messages.css('height', height).empty();
        new_messages.forEach(function(message) {
          messages.append(message);
          message.fadeIn();
        });
        var myDiv = document.getElementById('scroll');
        myDiv.scrollTop = myDiv.scrollHeight;
        $('.messages').data('id', _this.data().id)
  }, 'json')
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
  var img = "<div class='grid_1'><img src='http://www.dummyimage.com/50x50/000000/fff'/></div>";
  var name = "<div class='grid_5'><h5>Conway Anderson</h5></div>";
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
  var img = "<div class='grid_1'><img src='http://www.dummyimage.com/50x50/000000/fff'/></div>";
  var name = "<div class='grid_5'><h5>Conway Anderson</h5></div>";
  var timestamp = "<div class='grid_2' id='timestamp'>" + formatDate(message.created_at) + "</div>";
  var videoPlayer = $("<div class='videoPlayer' id='" + message.value + "'></div>");
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
	        csrf: $('meta[name="csrf-token"]').attr('content'),
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
            console.log('test');
            var myDiv = document.getElementById('scroll');
            myDiv.scrollTop = myDiv.scrollHeight + 500;
            player = recorderManager.displayPlayer(data.value, TOKEN, "p" + data.value);
          });
    	  }
    );
}

function archiveLoadedHandler(event) {
    archive = event.archives[0];
    archive.startPlayback();
}




