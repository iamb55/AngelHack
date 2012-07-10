Apply = function() {
  var information = {},
      sent = false;

  this.init = function() {  
    if(readCookie('mentor-app') === '1') {
      $('.part3').show();
      $('#application').css({
        'min-height': '40px'
      });
    } else {
      $('.part1').show();
    }
    $('a[id*=li_ui_li_gen_]').css({marginBottom: '20px'}).html('<img src="/assets/linkedin-button-2.png" style="margin: 10px 0 0 80px" border="0"/>');
    
    IN.Event.on(IN, 'auth', apply.handleLinkedIn);
    
    $('input').focus('change', function() {
      $(this).css('color', 'black');
    })
    
    $('.bio').focus(function() {
      $(this).css('color', 'black');
      if($(this).val() === 'Tell us a bit about yourself and your interests...'){
        $(this).val('');
      }
    });
    
    $('.bio').blur(function() {
      $(this).css('color', '#A9A8A2');
      if($(this).val() === "") {
        $(this).val('Tell us a bit about yourself and your interests...');
      }
    })
    
    $('.tags').tagHandler();
    $('textarea').elastic();
    
    $('.create').on('click', apply.submitApplication);
  }
  
  this.handleLinkedIn = function() {
    IN.API.Profile('me').fields('id','skills','picture-url', 'first-name', 'last-name', 'twitter-accounts').result(function(profile) {
      var data = profile.values[0];
      console.log(data);
      information.name = data.firstName + " " + data.lastName;
      information.picture = data.pictureUrl;
      information.uid = data.id;
      if(data.twitterAccounts && data.twitterAccounts.values) $('.twitter').val("@" + data.twitterAccounts.values[0].providerAccountName);
      information.tags = []
      if(data.skills && data.skills.values) {
        for(var i = 0; i < data.skills.length; i++) {
          information.tags.push(data.skills.values[i].skill.name);
        }
      } 
      $('.part2').slideDown();
    })
  }
  
  this.submitApplication = function() {
    var invalid = false;
    information.email = $('.email').val();
    information.bio = $('.bio').val();
    information.twitter = $('.twitter').val();
    information.personal = $('.personal').val();
    information.tags = information.tags.concat($('.tags').tagHandler('getTags'));
    if(information.email === "") {
      $('.email').css('border', 'solid 1px red');
      invalid = true;
    }
    if(information.bio === 'Tell us a bit about yourself and your interests...') {
      $('.bio').css('border', 'solid 1px red');
      invalid = true;
    }
    if(information.tags === []) {
      $('.tags').css('border', 'solid 1px red');
      invalid = true;
    }
    if(invalid) return false;
    
    if(!sent) {
      sent = true;
      $.post('/apply', {application: information}, function() {
        $('.part2').fadeOut(300, function() {
          $('#application h2').fadeOut(100);
          $('#application').css({
            'min-height': '40px'
          })
          $('.part3').fadeIn(300);
          createCookie('mentor-app',1,60);
        });
      });
    }
  }
  
}

function createCookie(name,value,days) {
	if (days) {
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		var expires = "; expires="+date.toGMTString();
	}
	else var expires = "";
	document.cookie = name+"="+value+expires+"; path=/";
}

function readCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}

apply = new Apply();

