class MomentsController < ApplicationController

  #->Prelang (scaffolding:rails/scope_to_user)
  before_filter :require_user_signed_in, only: [:new, :edit, :create, :update, :destroy]

  before_action :set_moment, only: [:show, :edit, :update, :destroy, :vote]

  # GET /moments
  # GET /moments.json
  def index
    @moments = Moment.all
  end

  # GET /moments/1
  # GET /moments/1.json
  def show
  end

  # GET /moments/new
  def new
    @moment = Moment.new
  end

  # GET /moments/1/edit
  def edit
  end

  # POST /moments
  # POST /moments.json
  def create
    @moment = Moment.new(moment_params)
    @moment.user = current_user

    respond_to do |format|
      if @moment.save
        format.html { redirect_to @moment, notice: 'Moment was successfully created.' }
        format.json { render :show, status: :created, location: @moment }
      else
        format.html { render :new }
        format.json { render json: @moment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /moments/1
  # PATCH/PUT /moments/1.json
  def update
    respond_to do |format|
      if @moment.update(moment_params)
        format.html { redirect_to @moment, notice: 'Moment was successfully updated.' }
        format.json { render :show, status: :ok, location: @moment }
      else
        format.html { render :edit }
        format.json { render json: @moment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moments/1
  # DELETE /moments/1.json
  def destroy
    @moment.destroy
    respond_to do |format|
      format.html { redirect_to moments_url, notice: 'Moment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  #->Prelang (voting/acts_as_votable)
  def vote

    direction = params[:direction]

    # Make sure we've specified a direction
    raise "No direction parameter specified to #vote action." unless direction

    # Make sure the direction is valid
    unless ["like", "bad"].member? direction
      raise "Direction '#{direction}' is not a valid direction for vote method."
    end

    @moment.vote_by voter: current_user, vote: direction

    redirect_to action: :index
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_moment
      @moment = Moment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def moment_params
      params.require(:moment).permit(:user_id, :description, :happened_at, :place_id)
    end
end
