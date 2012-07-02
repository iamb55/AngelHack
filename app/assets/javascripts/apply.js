Apply = function() {
  var information = {};

  this.init = function() {  
    $('.facebook').on('click', apply.handle_facebook);
    
    $('input').focus('change', function() {
      $(this).css('color', 'black');
    })
    
    $('textarea').focus(function() {
      $(this).css('color', 'black');
      if($(this).val() === 'Tell us a bit about yourself and your interests...'){
        $(this).val('');
      }
    });
    
    $('textarea').blur(function() {
      $(this).css('color', '#A9A8A2');
      if($(this).val() === "") {
        $(this).val('Tell us a bit about yourself and your interests...');
      }
    })
    
    $('textarea').elastic();
    
    $('.create').on('click', apply.submitApplication);
  }
  
  
  this.handle_facebook = function() {
    FB.login(function(response) {
       if (response.authResponse) {
         FB.api('/me', function(response) {
           FB.api('/me/picture', function(r2) {
              $('.facebook').fadeOut(300, function() {
                $('#application h2').fadeOut(200, function() {
                  $('#application h2').text('Glad to have you as a mentor, ' + response.first_name).fadeIn(200);
                })
                information.picture = r2;
                information.name = response.name;
                information.education = JSON.stringify(response.education);
                information.work = JSON.stringify(response.work);
                information.uid = response.id;
                $('.email').val(response.email);
                $('.part2').slideDown(500);
              });
              
           })
         }, {scope: 'email,user_education_history,user_work_history'});
       } else {

       }
     });
  }
  
  this.submitApplication = function() {
    var invalid = false;
    information.email = $('.email').val();
    information.bio = $('.bio').val();
    information.twitter = $('.twitter').val();
    information.linkedin = $('.linkedin').val();
    information.personal = $('.personal').val();
    if(information.email === "") {
      $('.email').css('border', 'solid 1px red');
      invalid = true;
    }
    if(information.bio === 'Tell us a bit about yourself and your interests...') {
      $('.bio').css('border', 'solid 1px red');
      invalid = true;
    }
    if(invalid) return false;
    
    $.post('/apply', {application: information}, function() {
      $('.part2').fadeOut(300, function() {
        $('#application h2').fadeOut(100);
        $('.part3').fadeIn(300);
      })
    })
  }
  
}


apply = new Apply();

Loader.register(function() {
  apply.init();
});