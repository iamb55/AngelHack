class AppsController < ApplicationController
  layout :false
  
  def apply
  end
  
  def create
    tags = params[:application].delete(:tags)
    invite = params[:application].delete(:invite)
    app = App.create(params[:application])
    app.add_tags(tags)
    if invite = Invitation.find_by_token(invite)
      token = Digest::SHA1.hexdigest(app.email)
      app.update_attribute(:token, token)
      render status: 200, json: { token: token }
    else
      render status: 200, nothing: true
    end
  end
end