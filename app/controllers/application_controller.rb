class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :current_user

  rescue_from CanCan::AccessDenied do |exception|
    binding.pry
    redirect_to '/' # TODO Update to redirect to main dashboard
  end

  helper_method :current_user, :current_user=
  
  private
   
    def current_user
      Mentor.first
      # return @current_user unless @current_user.nil?
      # if session[:user_id]
      #   if session[:type] == 'Mentor'
      #     @current_user = Mentor.find(session[:user_id])
      #   else
      #     @current_user = Mentee.find(session[:user_id])
      #   end
      # end
    end
    
    def current_user=(user)
      @current_user = user
    end
end
