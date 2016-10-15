class PointsController < ApplicationController

  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy, :like, :unlike]
  before_filter :require_user_is_owner, only: [:edit, :update, :destroy]
  before_filter :require_user_is_not_owner, only: [:like, :unlike]

  before_action :set_point, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :update_last_seen_time, only: [:create, :update, :destroy, :like, :unlike]

  # GET /points
  # GET /points.json
  def index
    @points = Point.order(:created_at => :desc).page(params[:page]).per(10)
  end

  # GET /feed.rss
  def feed
    @points = Point.all.first(50)
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  # GET /points/1
  # GET /points/1.json
  def show
  end

  # GET /points/new
  def new
    @point = Point.new
  end

  # POST /points
  # POST /points.json
  def create
    @point = Point.new(point_params)
    @point.user_id = current_user.id

    respond_to do |format|
      if @point.save
        format.html { redirect_to @point, notice: 'Created, thank you.' }
        format.json { render :show, status: :created, location: @point }
      else
        format.html { 
          flash[:notice] = 'There was a problem creating this:<br /><br /> ' + @point.errors.full_messages.join(', <br />')
          render :edit 
        }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /points/1/edit
  def edit
  end

  # PATCH/PUT /points/1
  # PATCH/PUT /points/1.json
  def update
    respond_to do |format|
      if @point.update(point_params)
        format.html { redirect_to @point, notice: 'Updated, thanks!' }
        format.json { render :show, status: :ok, location: @point }
      else
        format.html { 
          flash[:notice] = 'There was a problem updating this. ' + @point.errors.full_messages.join(', ')
          render :edit 
        }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /points/1
  # DELETE /points/1.json
  def destroy
    @point.destroy
    respond_to do |format|
      format.html { redirect_to points_url, notice: 'Deleted.' }
      format.json { head :no_content }
    end
  end

  # GET /points/1/like
  # GET /points/1/like.json
  def like
    @point.liked_by current_user

    respond_to do |format|
      format.html { redirect_to action: :show, id: params[:id] }
      format.json { head :no_content }
    end
  end

  # GET /points/1/unlike
  # GET /points/1/unlike.json
  def unlike
    @point.unliked_by current_user

    respond_to do |format|
      format.html { redirect_to action: :show, id: params[:id] }
      format.json { head :no_content }
    end
  end

  private

  def set_point
    @point = Point.find(params[:id])
  end

  def point_params
    params.require(:point).permit(:description, :location, :moment, :accomplices)
  end

  def fallback_redirect
    if request.env['HTTP_REFERER']
      return :back
    elsif defined?(root_path)
      return root_path
    else
      return "/"
    end
  end

  def require_user_is_owner
    @point = Point.find(params[:id])
    unless @point.user.id == current_user.id
      redirect_to fallback_redirect, flash: {error: "You may not change other users' contributions."}
    end
  end

  def require_user_is_not_owner
    @point = Point.find(params[:id])
    if @point.user.id == current_user.id
      redirect_to fallback_redirect, flash: {error: "You may not adjust your own points' reputations."}
    end
  end

end
