class Api::ConversationsController < Api::BaseController
  before_filter :authenticate_user!
  respond_to :json
  
  def all
  end
  
  def show
  end
end