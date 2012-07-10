class MenteeAppsController < ApplicationController
  protect_from_forgery :except => :create
  layout :false
  
  def create
    MenteeApp.create(info: params[:info], email: params[:email])
    render status: 200, nothing: true
  end
end