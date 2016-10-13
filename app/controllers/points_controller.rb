class PointsController < ApplicationController

  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy, :vote]
  before_filter :require_user_is_owner,  only: [:edit, :update, :destroy]

  before_action :set_point, only: [:show, :edit, :update, :destroy, :vote]
  before_action :update_last_seen_time, only: [:create, :update, :destroy, :vote]

  # GET /points
  # GET /points.json
  def index
    @points = Point.all
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
    @point.user = current_user

    respond_to do |format|
      if @point.save
        format.html { redirect_to @point, notice: 'Created, thank you.' }
        format.json { render :show, status: :created, location: @point }
      else
        format.html { 
          flash[:notice] = 'There was a problem creating this. ' + @point.errors.full_messages.join(', ')
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


  def vote
    direction = params[:direction]

    # Make sure we've specified a direction
    raise "No direction parameter specified to #vote action." unless direction

    # Make sure the direction is valid
    unless ["like", "bad"].member? direction
      raise "Direction '#{direction}' is not a valid direction for vote method."
    end

    @point.vote_by voter: current_user, vote: direction

    redirect_to action: :index
  end


  private

  def set_point
    @point = Point.find(params[:id])
  end

  def point_params
    params.require(:point).permit(:description)
  end

  def require_user_is_owner
    @point = Point.find(params[:id])
    unless @point.user.id == current_user.id

      # If the user came from a page, we can send them back.  Otherwise, send
      # them to the root path.
      if request.env['HTTP_REFERER']
        fallback_redirect = :back
      elsif defined?(root_path)
        fallback_redirect = root_path
      else
        fallback_redirect = "/"
      end

      redirect_to fallback_redirect, flash: {error: "You may not change other users' contributions."}
    end
  end

end
