class AppsController < ApplicationController
  layout :false
  
  def apply
  end
  
  def create
    tags = params[:application].delete(:tags)
    app = App.create(params[:application])
    tags.each do |tag|
      app.tags.create(value: tag)
    end
    render status: 200, nothing: true
  end
end