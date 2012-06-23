class EmailsController < ApplicationController
  protect_from_forgery :except => :add_email
  
  def add_email
    Email.create email: params[:email], mentor: params[:mentor]
    render nothing: true, status: 200
  end
  
end