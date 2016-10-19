class LandingsController < ApplicationController
 
  layout "infinite_scroll"

  def index
    @activity = Point.recent
    @here_today = User.here_today
  	if user_signed_in?
      @newcomers = User.newcomers
      # @points = current_user.timeline.page(params[:page]).per(10)
      @points = Point.timeline.page(params[:page]).per(10)
  		render :home
  	else
      @points = Point.timeline.page(params[:page]).per(10)
  		render :guest
  	end
  end
end
