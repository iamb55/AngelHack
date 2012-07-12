class RatingsController < ApplicationController
  def create
    conv = Conversation.find(params[:conversation_id])
    @rating = conv.mentor.ratings.create(value: params[:rating])
    @rating.update_attribute(:mentee_id, conv.mentee_id)

    respond_to do |format|
      if @rating.save
        format.json { render json: @rating, status: :created }
      end
    end
  end
end
