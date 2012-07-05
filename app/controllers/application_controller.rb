class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :current_user

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/unauthorized.wtf' # TODO Update to redirect to main dashboard
  end

  helper_method :current_user, :current_user=

  def after_sign_in_path_for(resource)
    @resource = resource
    if resource.user_type == 'mentor'
      "/mentors/#{resource.id}/conversations" 
    elsif resource.user_type == 'mentee'
      "/mentees/#{resource.id}/conversations"
    else
      '/'
    end
  end
  
  private
   
    def current_user
      return Mentor.first
      return @current_user unless @current_user.nil?
      
      if @resource.user_type = 'mentor'
        @current_user = current_mentor
      else
        @current_user = current_mentee
      end
    end
    
    def current_user=(user)
      @current_user = user
    end
end
