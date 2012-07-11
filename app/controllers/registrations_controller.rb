require 'pry'
class RegistrationsController < Devise::RegistrationsController
  layout :false
  
  def new
    super
  end

  def create
    if params[:mentee]
      if app = MenteeApp.find_by_token(params[:mentee].delete(:token))
        super
      else
        redirect_to '/'
      end
    else
      if app = App.find_by_token(params[:mentor].delete(:token))
        super
          binding.pry
        mentor = Mentor.find_by_email(params[:email])
        mentor.update_attributes({ 
          :first_name => app.name.split[0],
          :last_name => app.name.split.slice(1, app.name.split.size).join(' '),
          :picture_url => app.picture 
        })
        mentor.add_tags(app.tags.collect {|t| t.value}.uniq)
      else
        redirect_to '/'
      end
    end
  end

  def update
    super
  end
end
