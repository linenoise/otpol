class LandingsController < ApplicationController
 
  layout "infinite_scroll"

  def index
    @activity = Point.recent
    @here_today = User.here_today
    @points = Point.timeline.order(:created_at => :desc).page(params[:page]).per(10)
  	if user_signed_in?
      @newcomers = User.newcomers
  		render :home
  	else
  		render :guest
  	end
  end
end
