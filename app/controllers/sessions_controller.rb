class SessionsController < ApplicationController
  layout false
  
  FACEBOOK_SCOPE='user_likes,user_photos,friends_about_me,friends_likes,email'
  
  def new
    redirect_to '/mentors/' + session[:user_id].to_s + '/conversations' if session[:type] == 'Mentor' && session[:user_id]
    redirect_to '/mentees/' + session[:user_id].to_s + '/conversations' if session[:type] == 'Mentee' && session[:user_id] 
  end
  
  def start_session
    session[:type] = params[:type]
    session[:access_token] = nil
    redirect_to authenticator.url_for_oauth_code(:permissions => FACEBOOK_SCOPE)
  end
  
  def create
    session[:access_token] = authenticator.get_access_token(params[:code])
    if session[:type] == 'Mentor'
      current_user = Mentor.find_or_create_from_fb(session[:access_token])
      session[:user_id] = current_user.id
      redirect_to '/mentors/' + current_user.id.to_s + '/conversations'
    elsif session[:type] == 'Mentee'
      current_user = Mentee.find_or_create_from_fb(session[:access_token])
      session[:user_id] = current_user.id
      redirect_to '/mentees/' + current_user.id.to_s + '/conversations'
    else
      redirect_to '/'
    end
  end

  
  def destroy
    session[:user_id] = nil
    session[:type] = nil
    session[:access_token] = nil
    current_user = nil
    redirect_to '/'
  end
  
  def failure
    render text: "<p>We're very sorry, but your authentication failed! Please <a href='/sign_in'>visit the login page</a> and try again</p>"
  end
  
  protected
   def authenticator
     @authenticator ||= Koala::Facebook::OAuth.new(ENV["FACEBOOK_APP_ID"], ENV["FACEBOOK_SECRET"], 'http://mentor.im/auth/facebook/callback')
   end
end

