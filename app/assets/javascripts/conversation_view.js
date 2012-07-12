Conversation = function() {
  var questionID, message;
  var videoAnswer = false;
  var message_data = {};
  var mentee = false;
  var submitted = false;

  this.init = function() {
    $.ajaxSetup({
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
      }
    });
    
    message = $('.message-template').html();
    message = Handlebars.compile(message);

    if(getParameterByName('conversation_id')) {
      var el = $("[data-id='" + getParameterByName('conversation_id') + "']");
      conversation.changeConversation(el[0]);
    }
    $('.user').first().addClass('active');
    $('.user').on('click', function() { conversation.changeConversation(this) } );
    $('.send').on('click', conversation.respond);

    // $('.replybar textarea').keypress(function(e) {
    //   if (e.keyCode == 13 && !e.shiftKey) {
    //     e.preventDefault();
    //     conversation.respond();
    //   }
    // });

    $('.replybar textarea').focus(function() {
        if( $(this).val() == "Compose a new message..." ) {
            $(this).val("");
        }
        $(this).animate({
          height: '100px'
        }).css('color', 'black');
        $('.replybar .rightf').slideDown(250);
    });
    
    $(".replybar textarea").blur(function(e, wasTriggered) {
        if( $(this).val() == "" && !videoAnswer || wasTriggered) {
            $(this).val("Compose a new message...");
            $(this).css('color', '#aaa');
            
            $(this).animate({
              height: '50px'
            }).css('color', '#aaa');
            $('.replybar .rightf').slideUp(250);
            $('.video-preview').remove();
        }
        
    });
    
    $('.video').on('mousedown', function(e) {
      videoAnswer = true;
    });
    
    $('.video').on('mouseup', function(e) {
      conversation.respondVideo();
    });
    
    conversation.processVideos();

    if($('#newq').length != 0) {
      mentee = true;
      $('#newq').on('click', function() {
        $('#newQuestion').reveal();
      });
      
      
      $('.tags').tagHandler({
          getData: {},
          getURL: '/tags.json',
          autocomplete: true,
          minChars: 1
      });
      

      $('.submitQ').on('click', function() {
        conversation.addQuestion();
      });

      $('.close-reveal-modal').on('click', function() {
        $('.tagItem').remove();
      });
      
      $('#newQuestion textarea').keypress(function(e) {
        if (e.keyCode == 13 && !e.shiftKey) {
          e.preventDefault();
          conversation.addQuestion();
        }
      });
      
      $('.good').on('click', function() {
        if(!submitted) {
          submitted = true;
          $.post('/ratings',
          {
            conversation_id: $('.messages').data().id,
            rating: "good"
          }, function() {
              submitted = false;
              $('#ratingModal .close-reveal-modal').trigger('click');
          })
        }
      });
      
      $('.bad').on('click', function() {
        if(!submitted) {
          submitted = true;
          $.post('/ratings',
          {
            conversation_id: $('.messages').data().id,
            rating: "bad"
          }, function() {
              submitted = false;
              $('#ratingModal .close-reveal-modal').trigger('click');
          });
        }
      });
    }


  }

  this.addQuestion = function(t) {
    var content = $('#newQuestion textarea').val();
    $.post('/conversations',
      {
        text: content,
        tags: $('.tags').tagHandler('getTags')
      }, 
      function() {
        $('#newQuestion textarea, #newQuestion .button, #newQuestion h2, .tags').hide();
        $('#newQuestion h1').text("We'll connect you with a mentor as quickly as possible!");
        setTimeout(function() {
            $('.close-reveal-modal').trigger('click');
            setTimeout(function() {
              $('#newQuestion textarea').val('');
              $('#newQuestion textarea, #newQuestion .button').show();
              $('.tags').show();
              $('#newQuestion h2').show();
              $('#newQuestion h1').text("Ask a question to find a mentor!");
            }, 1000);
         }, 1500);
      }
    );
  }


  this.respond = function() {
    message_data.text = $('.replybar textarea').val();
    message_data.conversation_id = $('.messages').data().id;
    $.post('/messages', 
          message_data,
          function(data) {
            $('.replybar textarea').val('');
            var m = $(message(data.message));
            $('.messages ul').append(m);
            m.fadeIn(1000, function() {
              var myDiv = document.getElementById('scroll');
              myDiv.scrollTop = myDiv.scrollHeight + 200;
            });
            message_data = {};
            videoAnswer = false;
            $(".replybar textarea").trigger('blur', 'true');
            if(mentee && data.num_messages % 7 === 0) {
              $('#ratingModal').reveal();
            }
          }
    );
  }

  this.changeConversation = function(t) {
    var _this = $(t);
    $('.active').removeClass('active');
    _this.addClass('active');
    $.get('/conversations/' + _this.data().id + ".json",
        function(response) {
          var new_messages = []
          var messages = $('.messages ul');
          response.forEach(function(m) {
            new_messages.push($(message(m)).hide());
          });
          var height = $('.messages').height();
          messages.css('height', height).empty();
          new_messages.forEach(function(message) {
            messages.append(message);
            message.fadeIn();
          });
          conversation.processVideos();
          if(response[0].text.length > 75) {
            $('.messages h2').text(response[0].text.substring(0, 75) + "...");
          } else {
            $('.messages h2').text(response[0].text);
          }
          
          var myDiv = document.getElementById('scroll');
          myDiv.scrollTop = myDiv.scrollHeight + 100;
          $('.messages').data('id', _this.data().id);
          $(".replybar textarea").trigger('blur', 'true');
    }, 'json')
  }

  this.processVideos = function() {
    videoPlayers = $('.videoPlayer');

    videoPlayers.each(function(player) {
      player = $(videoPlayers[player]);
      var id = player.data('id');
      tokbox.recorderManager.displayPlayer(id, OPENTOK_TOKEN, "p" + id);
    });
    if ($('.message').length > 0) {
      setTimeout(function() {
        var myDiv = document.getElementById('scroll');
        myDiv.scrollTop = myDiv.scrollHeight + 200;
      }, 500);
    }
  }

  this.respondVideo = function() {
      $('#videoModal').reveal();
      tokbox.createRecorder(conversation.archiveSavedHandler);
      questionID = $('.messages').data('id');
  }
  
  this.archiveSavedHandler = function(event) {
    $('.replybar left').remove();
    message_data.video = event.archives[0].archiveId;
    var div = $('<div class="leftf video-preview"><div id="preview"></div></div>');
    div.attr('id', message_data.video);
    $('.replybar').append(div)
    tokbox.recorderManager.displayPlayer(message_data.video, OPENTOK_TOKEN, 'preview');
    $('.close-reveal-modal').trigger('click');
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



