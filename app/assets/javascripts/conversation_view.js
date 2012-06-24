$(document).ready(function() {
  $('.user').on('click', function() { changeConversation(this) } );
  
});


function changeConversation(t) {
  var _this = $(t);
  $.get('/conversations/' + _this.data().id + ".json",
      function(response) {
        new_messages = $("<div class='messages'></div>");
        new_messages.css('display','none');
        response.forEach(function(message) {
          var m = $("<div class='" + message.owner_type + "'></div>");
          m.append("<p>" + message.value + "</p>");
          m.append("<span>" + message.created_at + "</p>");
          new_messages.append(m);
        });
        $('.messages').hide();
        $('.messages').replaceWith(new_messages);
        $('.messages').slideDown(1000);
  }, 'json')
}