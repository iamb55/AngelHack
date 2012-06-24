class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :current_user
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to conversations_path # TODO Update to redirect to main dashboard
  end

  protected
   
    def current_user
      Mentor.first
    end
end
