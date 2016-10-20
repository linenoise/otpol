class LandingsController < ApplicationController
 
  layout "infinite_scroll"

  def index
    @activity = Point.recent
    @here_today = User.here_today

  	if user_signed_in?
      home
  	else
  		guest
  	end
  end

  def home
    @newcomers = User.newcomers

    @people_to_follow = User.people_to_follow.keep_if { |this_user|
      current_user.can_follow(this_user) &&
      ! current_user.is_following(this_user)
    }

    @points = current_user.timeline.page(params[:page]).per(10)
    if @points.length == 0
      @points = Point.timeline.page(params[:page]).per(10)

      if current_user.following.length == 0
        flash[:notice] = 'It looks like you have\'nt followed anyone or written anything yet, so here are a selection of new stories from people. Why not follow a few of them?' 
      else
        flash[:notice] = 'It looks like the people you follow haven\'t written anything yet, so here are a selection of new stories from people.' 
      end        
    end
    render :action => :home
  end

  def guest
    @points = Point.timeline.page(params[:page]).per(10)
    render :action => :guest
  end

end
