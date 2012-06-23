$(document).ready(function() {
  $('.user').on('click', function() { changeConversation(this) } );
  
});


function changeConversation(t) {
  var _this = $(t);
  $.get({
    url: '/conversations/get_conversation.json',
    data: { 'id': _this.data().id },
    success: function(response) {
      var data = response.data;
      var new_messages = $("<div class='messages'></div>");
      data.messages.forEach(function(message) {
        var m = $(ich.message(message));
        if (m.type === "mentor") m.addClass('mentor');
        new_messages.append(m);
      });
      $('.messages').hide();
      $('.messages').replaceWith(new_messages);
      $('.messages').fadeIn();
    }
  }, 'json')
}