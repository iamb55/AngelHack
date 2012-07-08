class SessionsController < Devise::SessionsController
  layout :false
  
  def create
    super
  end
  
  def destroy
    super
  end
end