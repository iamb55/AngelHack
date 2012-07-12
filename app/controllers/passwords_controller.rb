class PasswordsController < Devise::PasswordsController
  prepend_before_filter :require_no_authentication
  # Render the #edit only if coming from a reset password email link
  append_before_filter :assert_reset_token_passed, :only => :edit
  
  layout 'headerless'
  
  def new
    super
  end
  
  def create
    if Mentor.find_by_email(params[:mentor][:email])
      self.resource = resource_class.send_reset_password_instructions(resource_params)
      resource_name = :mentor
    else
      resource_name = :mentee
      resource_class = Mentee
      params[:mentee] = params.delete(:mentor)
      self.resource = resource_class.send_reset_password_instructions(params[:mentee])
    end
    
    if successfully_sent?(resource)
      respond_with({}, :location => after_sending_reset_password_instructions_path_for(resource_name))
    else
      respond_with(resource)
    end
  end

  def edit
    self.resource = resource_class.new
    resource.reset_password_token = params[:reset_password_token]
  end
end
