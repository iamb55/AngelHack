class SessionsController < ApplicationController
  def new
    redirect_to 'mentors#conversations' if session[:type] == 'Mentor' && session[:user_id]
    redirect_to 'mentees#conversations' if session[:type] == 'Mentee' && session[:user_id] 
  end
  
  def start_session
    session[:type] = params[:type]
    redirect_to '/auth/singly?service=#{service}'
  end
  
  def create
    auth = request.env['omniauth.auth']
    if session[:type] == 'Mentor'
      current_user = Mentor.find_or_create_from_singly(auth)
    elsif session[:type] == 'Mentee'
      current_user = Mentee.find_or_create_from_singly(auth)
    else
      redirect_to root_Url
    end
  end
  
  def destroy
    session[:user_id] = nil
    session[:type] = nil
    redirect_to root_url
  end
end
