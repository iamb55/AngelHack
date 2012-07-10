class AppsController < ApplicationController
  layout :false
  
  def apply
  end
  
  def create
    tags = params[:application].delete(:tags)
    app = App.create(params[:application])
    app.add_tags(tags)
    render status: 200, nothing: true
  end
end