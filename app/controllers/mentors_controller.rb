class MentorsController < ApplicationController
  # GET /mentors
  # GET /mentors.json
  def index
    @mentors = Mentor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mentors }
    end
  end

  # GET /mentors/1
  # GET /mentors/1.json
  def show
    @mentor = Mentor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mentor }
    end
  end

  # GET /mentors/new
  # GET /mentors/new.json
  def new
    @mentor = Mentor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mentor }
    end
  end

  # GET /mentors/1/edit
  def edit
    @mentor = Mentor.find(params[:id])
  end

  # POST /mentors
  # POST /mentors.json
  def create
    @mentor = Mentor.new(params[:mentor])

    respond_to do |format|
      if @mentor.save
        format.html { redirect_to @mentor, notice: 'Mentor was successfully created.' }
        format.json { render json: @mentor, status: :created, location: @mentor }
      else
        format.html { render action: "new" }
        format.json { render json: @mentor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mentors/1
  # PUT /mentors/1.json
  def update
    @mentor = Mentor.find(params[:id])

    respond_to do |format|
      if @mentor.update_attributes(params[:mentor])
        format.html { redirect_to @mentor, notice: 'Mentor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mentor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mentors/1
  # DELETE /mentors/1.json
  def destroy
    @mentor = Mentor.find(params[:id])
    @mentor.destroy

    respond_to do |format|
      format.html { redirect_to mentors_url }
      format.json { head :no_content }
    end
  end
end
