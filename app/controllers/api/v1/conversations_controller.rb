class Api::V1::ConversationsController < ApplicationController
  respond_to :json
  
  def all
    @user = Mentor.find_by_authentication_token(params[:mentor_token]) if params[:mentor_token]
    @user = Mentee.find_by_authentication_token(params[:mentee_token]) if params[:mentee_token]
    
    
    cs = @user.conversations
    unless cs.empty?
      conversations = cs.collect do |conversation|
        if @user.mentor?
          { recent_message: conversation.messages.last, updated_at: conversation.updated_at, partner: conversation.mentee, conversation_id: conversation.id }
        else
          { recent_message: conversation.messages.last, updated_at: conversation.updated_at, partner: conversation.mentor, conversation_id: conversation.id }
        end
      end
      p conversations
      render status: 200, json: conversations, nothing: true
    end
  end
  
  def show
    render status: 200, nothing: true
  end
end