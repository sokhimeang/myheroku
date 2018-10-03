class FeedbacksController < ApplicationController

  def index

  end

  def show
    @feedback = Feedback.includes(:messages).find_by(id: params[:id])
    @message = Message.new
  end

  def create

  end

  def new

  end

end
