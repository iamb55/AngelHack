$(document).ready(function() {
  
  $('.user').on('click', function() { changeConversation(this) } );
  $('.reply').on('click', respond);
  
  
  
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
          console.log('success!');
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



    return h + ":" + m;
}
