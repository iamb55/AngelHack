class Api::V1::ConversationsController < ApplicationController
  respond_to :json
  
  def all
    data = { success: false }
    @user = Mentor.find_by_authentication_token(params[:mentor_token]) if params[:mentor_token]
    @user = Mentee.find_by_authentication_token(params[:mentee_token]) if params[:mentee_token]
    
    unless @user
      data[:message] = "Invalid user token loser."
      render status: 400, json: data, nothing: true 
      return
    end
    
    cs = @user.conversations
    unless cs.empty?
      conversations = cs.collect do |conversation|
        if @user.mentor?
          { recent_message: conversation.messages.last, updated_at: conversation.updated_at, partner: conversation.mentee, conversation_id: conversation.id }
        else
          { recent_message: conversation.messages.last, updated_at: conversation.updated_at, partner: conversation.mentor, conversation_id: conversation.id }
        end
      end
      data[:conversations] = conversations
      data[:success] = true
      render status: 200, json: conversations, nothing: true
      return
    end
    data[:conversations] = []
    data[:success] = true
    render status: 200, json: data, nothing: true
  end
  
  def show
    data = { success: false }
    
    @user = Mentor.find_by_authentication_token(params[:mentor_token]) if params[:mentor_token]
    @user = Mentee.find_by_authentication_token(params[:mentee_token]) if params[:mentee_token]
    
    unless @user
      data[:message] = "Invalid user token loser."
      render status: 400, json: data, nothing: true 
      return
    end
    
    conversation = @user.conversations.find_by_id(params[:id])
    
    unless conversation
      data[:message] = "Invalid conversation id loser."
      render status: 400, json: data, nothing: true 
      return
    end
    
    render status: 200, json: conversation, nothing: true
  end
end