class LandingsController < ApplicationController
  def index
  	@points = Point.all
  	@active_today = User.active.sort { |x, y| x.display_name <=> y.display_name } 
  	@newcomers = User.newcomers.sort { |x, y| x.display_name <=> y.display_name }

  	if user_signed_in?
  		render :home
  	else
  		render :guest
  	end
  end
end
