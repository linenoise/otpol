class RelationshipsController < ApplicationController

  before_action :deflect_blocked_users, only: [:block, :follow, :unfollow, :friend, :unfriend]

  def block
    if current_user.is_blocking(@user)
      redirect_to person_path(:id => current_user.username ), notice: "You're already blocking #{@user.display_name}."
    elsif current_user.can_block(@user)
      if current_user.is_following(@user)
        current_user.unfollow(@user)
      end
      if @user.is_following(current_user)
        @user.unfollow(current_user)
      end
      current_user.block(@user)
      redirect_to person_path(:id => current_user.username ), notice: "You're now blocking #{@user.display_name}."
    else
      redirect_to person_path(:id => current_user.username ), notice: "You can't block yourself."
    end
  end

  def unblock
    @user = User.find_by_username(params[:id])
    unless @user
      raise ActiveRecord::RecordNotFound
    end
    if current_user.is_blocking(@user)
      current_user.unblock(@user)
      redirect_to person_path(:id => @user.username ), notice: "You're no longer blocking #{@user.display_name}."
    else
      redirect_to person_path(:id => @user.username ), notice: "You aren't blocking #{@user.display_name}."
    end
  end

  def follow
    if current_user.is_following(@user)
      redirect_to person_path(:id => @user.username ), notice: "You're already following #{@user.display_name}."
    elsif current_user.username == @user.username
      redirect_to person_path(:id => @user.username ), notice: "You can't follow yourself."
    elsif current_user.can_follow(@user)
      current_user.follow(@user)
      redirect_to person_path(:id => @user.username ), notice: "You're now following #{@user.display_name}."
    else
      redirect_to person_path(:id => @user.username ), notice: "You can't follow #{@user.display_name} at this time."
    end
  end

  def unfollow
    if current_user.username == @user.username
      redirect_to person_path(:id => @user.username ), notice: "You can't unfollow yourself."
    elsif current_user.is_following(@user)
      current_user.unfollow(@user)
      redirect_to person_path(:id => @user.username ), notice: "You're no longer following #{@user.display_name}."
    else
      redirect_to person_path(:id => @user.username ), notice: "You aren't following #{@user.display_name}."
    end
  end

  private

  def deflect_blocked_users
    @user = User.find_by_username(params[:id])
    unless @user
      raise ActiveRecord::RecordNotFound
    end
    if current_user.is_blocked_from(@user)
      redirect_to root_path
    end
  end
end
