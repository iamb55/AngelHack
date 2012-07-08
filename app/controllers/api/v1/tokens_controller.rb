class Api::V1::TokensController < ApplicationController
    skip_before_filter :verify_authenticity_token
    respond_to :json
    
    def create
      email = params[:email]
      password = params[:password]

      data = { success: false }
      if request.format != :json
        render :status=>406, :json=>{:message=>"The request must be json"}
        return
       end

    if email.nil? or password.nil?
       render :status=>400,
              :json=>{:message=>"The request must contain the user email and password."}
       return
    end

    @mentor = Mentor.find_by_email(email.downcase)
    @mentee = Mentee.find_by_email(email.downcase)

    if @mentor.nil? && @mentee.nil?
      logger.info("User #{email} failed signin, user cannot be found.")
      render status: 401, json: {message: "Invalid email."}
      return
    end
    # http://rdoc.info/github/plataformatec/devise/master/Devise/Models/TokenAuthenticatable
    if @mentor
      @mentor.ensure_authentication_token! 
      if @mentor.valid_password?(password)
        data[:mentor] = @mentor
        data[:mentor_token] = @mentor.authentication_token
      end
    end
    
    if @mentee
      @mentee.ensure_authentication_token! 
      if @mentee.valid_password?(password)
        data[:mentee] = @mentee
        data[:mentee_token] = @mentee.authentication_token
      end
    end
    
    if data[:mentee].nil? && data[:mentor].nil?
      render status: 401, json: { message: "Invalid email or password." }
    else
      data[:success] = true
      render status: 200, json: data
    end
    
  end

  def destroy
    @user=User.find_by_authentication_token(params[:id])
    if @user.nil?
      logger.info('Token not found.')
      render :status=>404, :json=>{:message=>'Invalid token.'}
    else
      @user.reset_authentication_token!
      render :status=>200, :json=>{:token=>params[:id]}
    end
  end

end