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
    $('.respondButton').click(respond());
    recorderManager = TB.initRecorderManager(API_KEY);
    createRecorder();
});

var respond = function() {
    $('responseModal').reveal();
    questionID = $(this).parent().data('id');
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
    $.ajax({
	url: "/messages/new",
        method: "POST",
	data: {
	    csrf: $('meta[name="csrf-token"]').attr('content'),
	    value: event.archives[0].archiveId,
	    format: 'video',
	    questionID: questionID
	}
    });
}

function archiveLoadedHandler(event) {
    archive = event.archives[0];
    archive.startPlayback();
}



