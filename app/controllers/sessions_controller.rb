class SessionsController < Devise::SessionsController
  layout :false
  
  def create
    unless Mentor.find_by_email(params[:mentor][:email])
      auth_options = {scope: :mentee, recall: 'sessions#new'}
      resource_name = :mentee
      warden.config[:default_scope] = :mentee
      params[:mentee] = params.delete(:mentor)
      resource_name = :mentee
    else
      resource_name = :mentor
      auth_options = {scope: :mentor, recall: 'sessions#new'}
    end
    resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_with resource, :location => after_sign_in_path_for(resource)
  end

end