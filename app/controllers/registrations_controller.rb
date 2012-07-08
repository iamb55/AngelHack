require 'pry'
class RegistrationsController < Devise::RegistrationsController
  layout :false
  
  def new
    super
  end

  def create
    app = App.find_by_token(params[:mentor][:token])
    params[:mentor].delete(:token)
    # binding.pry
    first_name = app.name.split[0]
    last_name = app.name.split.slice(1, app.name.split.size).join(' ')
    picture_url = app.picture
    super
    Mentor.find_by_email(app.email).update_attributes({ :first_name => first_name,
                              :last_name => last_name,
                              :picture_url => picture_url })
  end

  def update
    super
  end
end
