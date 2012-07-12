require 'pry'
class RegistrationsController < Devise::RegistrationsController
  layout :false
  
  def new
    if app = (App.find_by_token(params[:token]) || MenteeApp.find_by_token(params[:token]))
      @email = app.email
    end
    super
  end

  def create
    if params[:mentee]
      if app = MenteeApp.find_by_token(params[:mentee].delete(:token))
        super
      else
        redirect_to '/'
      end
    else
      @token = params[:mentor].delete(:token)
      if app = App.find_by_token(@token)
        build_resource
        binding.pry
        if resource.save
          if resource.sign_in_count == 0
            resource.update_attributes({ 
              :first_name => app.name.split[0],
              :last_name => app.name.split.slice(1, app.name.split.size).join(' '),
              :picture_url => app.picture 
            })
            resource.add_tags(app.tags.collect {|t| t.value}.uniq)
          end
          if resource.active_for_authentication?
            set_flash_message :notice, :signed_up if is_navigational_format?
            sign_in(resource_name, resource)
            respond_with resource, :location => after_sign_up_path_for(resource)
          else
            set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
            expire_session_data_after_sign_in!
            respond_with resource, :location => after_inactive_sign_up_path_for(resource)
          end
        else
          clean_up_passwords resource
          respond_with resource
        end
      else
        redirect_to '/'
      end
    end
  end

  def update
    super
  end
end
