class LandingsController < ApplicationController
  def index
  	if user_signed_in?
  		render :home
  	else
  		render :guest
  	end
  end
end
