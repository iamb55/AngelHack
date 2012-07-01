TokBox = function() {
  var recorderManager, recorder, player, recImgData, sessionId;
  
  var API_KEY = '16288541',
      TOKEN = 'moderator_token',
      VIDEO_HEIGHT = 240,
      VIDEO_WIDTH = 320;
      
  this.init = function() {  
    this.recorderManager = TB.initRecorderManager(API_KEY);
  }
  


  this.getImg = function(imgData) {
      var img = document.createElement('img');
      img.setAttribute('src', imgData);
      return img;
  }


  //--------------------------------------
  //  OPENTOK EVENT HANDLERS
  //--------------------------------------

  this.recStartedHandler = function(event, recorder) {
      recImgData = recorder.getImgData();
  }


  this.archiveLoadedHandler = function(event) {
      archive = event.archives[0];
      archive.startPlayback();
  }
  
}

tokbox = new TokBox();

Loader.register(function() {
  tokbox.init();
});