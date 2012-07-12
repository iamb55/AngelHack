class MenteesController < ApplicationController
  load_and_authorize_resource
  
  before_filter :config_opentok
  # GET /mentees
  # GET /mentees.json
  def index
    @mentees = Mentee.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mentees }
    end
  end

  # GET /mentees/1
  # GET /mentees/1.json
  def show
    @mentee = Mentee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mentee }
    end
  end

  # GET /mentees/new
  # GET /mentees/new.json
  def new
    @mentee = Mentee.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mentee }
    end
  end

  # GET /mentees/1/edit
  def edit
    @mentee = Mentee.find(params[:id])
  end

  # POST /mentees
  # POST /mentees.json
  def create
    @mentee = Mentee.new(params[:mentee])

    respond_to do |format|
      if @mentee.save
        format.html { redirect_to @mentee, notice: 'Mentee was successfully created.' }
        format.json { render json: @mentee, status: :created, location: @mentee }
      else
        format.html { render action: "new" }
        format.json { render json: @mentee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mentees/1
  # PUT /mentees/1.json
  def update
    @mentee = Mentee.find(params[:id])

    respond_to do |format|
      if @mentee.update_attributes(params[:mentee])
        format.html { redirect_to @mentee, notice: 'Mentee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mentee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mentees/1
  # DELETE /mentees/1.json
  def destroy
    @mentee = Mentee.find(params[:id])
    @mentee.destroy

    respond_to do |format|
      format.html { redirect_to mentees_url }
      format.json { head :no_content }
    end
  end
  
  def conversations
    cs = current_mentee.conversations
    @unanswered = []
    unless cs.empty?
      @conversations = cs.collect do |conversation|
        if conversation.messages.count > 1
          { message: conversation.messages.last, updated_at: conversation.updated_at, user: conversation.mentor, id: conversation.id } 
        else
          @unanswered << { message: conversation.messages.last, updated_at: conversation.updated_at, user: conversation.mentor, id: conversation.id }
          nil
        end
      end.compact
      if @conversations.first
        @messages = Conversation.find(@conversations.first[:id]).messages
      else
        @messages = []
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_mentee)
  end
  

end
