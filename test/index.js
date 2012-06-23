
var recorderManager;
var recorder;
var player;
var recImgData;

var API_KEY = '16288541';
var TOKEN = 'moderator_token';

var VIDEO_HEIGHT = 240;
var VIDEO_WIDTH = 320;

$(document).ready(function() {
    init();
});


function init() {
    recorderManager = TB.initRecorderManager(API_KEY);
    createRecorder();
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
    alert(event.archives[0].archiveId);
    document.getElementById('archiveList').style.display = 'block';
    var aLink = document.createElement('a');
    aLink.setAttribute('href',"javascript:loadArchiveInPlayer(\'" + event.archives[0].archiveId + "\')");
    var recImg = getImg(recImgData);
    recImg.setAttribute('style', 'width:80; height:60; margin-right:2px');
    aLink.appendChild(recImg);
    document.getElementById('archiveList').appendChild(aLink);
}

function archiveLoadedHandler(event) {
    archive = event.archives[0];
    archive.startPlayback();
}

/*
  If you un-comment the call to TB.addEventListener('exception', exceptionHandler) above, OpenTok calls the
  exceptionHandler() method when exception events occur. You can modify this method to further process exception events.
  If you un-comment the call to TB.setLogLevel(), above, OpenTok automatically displays exception event messages.
*/
function exceptionHandler(event) {
    alert('Exception: ' + event.code + '::' + event.message);
}
