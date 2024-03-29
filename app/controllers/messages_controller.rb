class MessagesController < ApplicationController
  load_and_authorize_resource :except => [:create]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.json
  def create
    if params[:new_conversation]
      conversation = Conversation.find(params[:conversation_id])
      conversation.mentor_id = current_user.id
      conversation.save
      @message = Message.new
      @message.conversation_id = params[:conversation_id]
      @message.value = params[:value]
      @message.owner_type = current_user.user_type
      @message.data_type = params[:data_type]

    else
      conversation = Conversation.find(params[:conversation_id])
      if (conversation.nil? || ( conversation.mentor_id != current_user.id && conversation.mentee_id != current_user.id) )
        render status: 401, nothing: true
      end

      @message = Message.new
      @message.conversation_id = params[:conversation_id]
      @message.value = params[:value]
      @message.owner_type = current_user.user_type
      @message.data_type = params[:data_type]
    end
    
    if @message.save
      @data = @message.attributes
      owner = @message.conversation.send(@message.owner_type)
      @data['name'] = owner.first_name  
      @data['picture_url'] = owner.picture_url
      render status: 200, json: @data
    else
      render status: 500, nothing: true
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end
end
