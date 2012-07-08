class Api::V1::MessagesController < ApplicationController
  respond_to :json
  
  def create
    data = { success: false }
    
    @user = Mentor.find_by_authentication_token(params[:mentor_token]) if params[:mentor_token]
    @user = Mentee.find_by_authentication_token(params[:mentee_token]) if params[:mentee_token]
    
    unless @user
      data[:message] = "Invalid user token loser."
      render status: 400, json: data, nothing: true 
      return
    end
    
    conversation = @user.conversations.find_by_id(params[:conversation_id])
    
    unless conversation
      data[:message] = "Invalid conversation id loser."
      render status: 400, json: data, nothing: true 
      return
    end
    
    message = conversation.messages.create(text: params[:text], owner_type: @user.user_type)
    render status: 200, json: message, nothing: true
  end
end