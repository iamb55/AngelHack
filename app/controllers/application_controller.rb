class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :current_user

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/unauthorized.wtf' # TODO Update to redirect to main dashboard
  end

  helper_method :current_user, :config_opentok

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
  
     def config_opentok
       if @opentok.nil?
         @opentok = OpenTok::OpenTokSDK.new 16528271, "0a9472b4ebc4ed74440108b8a0023bcda2ada9c8"
         session_id = @opentok.create_session(request.host)
         @opentok_token = @opentok.generate_token(session_id: session_id, role: OpenTok::RoleConstants::MODERATOR)
       end
     end
     
    def current_user
      current_mentor || current_mentee
    end
    

end
