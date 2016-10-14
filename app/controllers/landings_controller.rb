class LandingsController < ApplicationController
  def index
    @active_recently = User.active_recently
  	if user_signed_in?
      @points = current_user.timeline
      @newcomers = User.newcomers
  		render :home
  	else
      @points = Point.timeline
  		render :guest
  	end
  end
end
