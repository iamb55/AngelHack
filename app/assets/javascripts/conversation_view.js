Conversation = function() {
  var questionID, text_message, video_message;

  this.init = function() {
    $.ajaxSetup({
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
      }
    });
    
    text_message = $('.text-message-template').html();
    text_message = Handlebars.compile(text_message);
    
    video_message = $('.video-message-template').html();
    video_message = Handlebars.compile(video_message);

    if(getParameterByName('conversation_id')) {
      var el = $("[data-id='" + getParameterByName('conversation_id') + "']");
      conversation.changeConversation(el[0]);
    }

    $('.user').on('click', function() { conversation.changeConversation(this) } );
    $('.text').on('click', conversation.respond);

    $('.replybar textarea').keypress(function(e) {
      if (e.keyCode == 13 && !e.shiftKey) {
        e.preventDefault();
        conversation.respond();
      }
    });

    $('.video').click(conversation.respondVideo);


    conversation.processVideos();

    if($('.newq').length != 0) {
      $('.newq').on('click', function() {
        $('#newQuestion').reveal();
      });

      $('.submitQ').on('click', function() {
        conversation.addQuestion();
      });

      $('#newQuestion textarea').keypress(function(e) {
        if (e.keyCode == 13 && !e.shiftKey) {
          e.preventDefault();
          conversation.addQuestion();
        }
      });
    }


  }

  this.addQuestion = function(t) {
    var content = $('#newQuestion textarea').val();
    $.post('/conversations',
      {
        data_type: 'text',
        value: content
      }, 
      function() {
        $('#newQuestion textarea, #newQuestion .button').hide();
        $('#newQuestion h1').text("We'll connect you with a mentor as quickly as possible!");
        setTimeout(function() {
            $('.close-reveal-modal').trigger('click');
            setTimeout(function() {
              $('#newQuestion textarea').val('');
              $('#newQuestion textarea, #newQuestion .button').show();
              $('#newQuestion h1').text("Ask a question to find a mentor!");
            }, 1000);
          }, 1500);
      }
    );
  }


  this.respond = function() {
    reply = $('.replybar textarea').val();
    conversation_id = $('.messages').data().id;
    $.post('/messages', 
          { 
            conversation_id: conversation_id, 
            data_type: 'text', 
            value: reply
          },
          function(data) {
            $('.replybar textarea').val('');
            var m = conversation.createMessage(data);
            $('.messages ul').append(m);
            m.fadeIn(1000, function() {
              var myDiv = document.getElementById('scroll');
              myDiv.scrollTop = myDiv.scrollHeight + 200;
            });
          }
    );
  }

  this.changeConversation = function(t) {
    var _this = $(t);
    $.get('/conversations/' + _this.data().id + ".json",
        function(response) {
          var new_messages = []
          var messages = $('.messages ul');
          response.forEach(function(message) {
            var li;
            console.log(message);
            if (message.data_type === 'text') li = text_message(message);
            else li = video_message(message);
            new_messages.push($(li).hide());
          });
          var height = $('.messages').height();
          messages.css('height', height).empty();
          new_messages.forEach(function(message) {
            messages.append(message);
            message.fadeIn();
          });
          conversation.processVideos();
          var myDiv = document.getElementById('scroll');
          myDiv.scrollTop = myDiv.scrollHeight + 1000;
          $('.messages').data('id', _this.data().id)
    }, 'json')
  }

  this.processVideos = function() {
    videoPlayers = $('.videoPlayer');

    videoPlayers.each(function(player) {
      player = $(videoPlayers[player]);
      var id = player.data('id');
      tokbox.recorderManager.displayPlayer(id, tokbox.TOKEN, "p" + id);
    });
    if ($('.message').length > 0) {
      setTimeout(function() {
        var myDiv = document.getElementById('scroll');
        myDiv.scrollTop = myDiv.scrollHeight + 200;
      }, 500);
    }
  }

  this.respondVideo = function() {
      $('#responseModal').reveal();
      questionID = $('.messages').data('id');
  }



}

//helpers
var getParameterByName = function(name)
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

var formatDate = function(date) {
    var d = new Date(date);
    var hh = d.getHours();
    var m = d.getMinutes() - 1;
    var s = d.getSeconds();
    var dd = "am";
    var h = hh;
    if (h >= 12) {
        h = hh-12;
        dd = "pm";
    }
    if (h == 0) {
        h = 12;
    }
    m = m<10?"0"+m:m;

    s = s<10?"0"+s:s;



    return h + ":" + m + " " + dd;
}

var conversation = new Conversation();

Loader.register(function() {
  conversation.init();
});



