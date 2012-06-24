class ConversationsController < ApplicationController
  load_and_authorize_resource
  # GET /conversations
  # GET /conversations.json
  def index
    @conversations = Conversation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @conversations }
    end
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages.collect do |message|
      @data = message.attributes
      owner = message.conversation.send(message.owner_type)
      @data['name'] = owner.first_name  
      @data['picture_url'] = owner.picture_url
      @data
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /conversations/new
  # GET /conversations/new.json
  def new
    @conversation = Conversation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @conversation }
    end
  end

  # GET /conversations/1/edit
  def edit
    @conversation = Conversation.find(params[:id])
  end

  # POST /conversations
  # POST /conversations.json
  def create
    @conversation = current_user.conversations.build
    m = @conversation.messages.build
    m.value = params[:value]
    m.data_type = params[:data_type]
    m.owner_type = current_user.user_type
    m.save

    respond_to do |format|
      if @conversation.save
        format.html { redirect_to @conversation, notice: 'Conversation was successfully created.' }
        format.json { render json: @conversation, status: :created, location: @conversation }
      else
        format.html { render action: "new" }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /conversations/1
  # PUT /conversations/1.json
  def update
    @conversation = Conversation.find(params[:id])

    respond_to do |format|
      if @conversation.update_attributes(params[:conversation])
        format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @conversation = Conversation.find(params[:id])
    @conversation.destroy

    respond_to do |format|
      format.html { redirect_to conversations_url }
      format.json { head :no_content }
    end
  end
end
