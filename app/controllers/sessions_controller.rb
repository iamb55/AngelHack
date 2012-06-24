class SessionsController < ApplicationController
  layout false
  
  def new
    redirect_to 'mentors#conversations' if session[:type] == 'Mentor' && session[:user_id]
    redirect_to 'mentees#conversations' if session[:type] == 'Mentee' && session[:user_id] 
  end
  
  def start_session
    session[:type] = params[:type]
    redirect_to "/auth/singly?service=facebook"
  end
  
  def create
    session[:access_token] = request.env['omniauth.auth'].credentials.token
    if session[:type] == 'Mentor'
      current_user = Mentor.find_or_create_from_singly(session[:access_token])
      session[:user_id] = current_user.id
      redirect_to '/mentors/' + current_user.id.to_s + '/conversations'
    elsif session[:type] == 'Mentee'
      current_user = Mentee.find_or_create_from_singly(session[:access_token])
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
end

