class AppsController < ApplicationController
  layout :false
  
  def apply
  end
  
  def create
    app = App.create(params[:application])
    p app
    render status: 200, nothing: true
  end
end