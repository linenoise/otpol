class PeopleController < ApplicationController

  before_filter :require_user_signed_in, only: [:edit, :update]
  before_action :set_self, only: [:edit, :update]
  before_action :update_last_seen_time, only: [:update]

  # GET /people/1
  # GET /people/1.json
  #
  # Shows a particular profile page
  def show
    @person = User.find_by_username(params[:id])
    unless @person
      raise ActiveRecord::RecordNotFound
    end
  end

  # GET /people/1/edit
  #
  # Edits your profile page
  def edit
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  #
  # Updates your profile page
  def update
    respond_to do |format|
      if @person.update_without_password(user_params)
        format.html { redirect_to person_path(current_user.username), notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { 
        	flash[:notice] = 'There was a problem updating your profile: ' + @person.errors.full_messages.join(', ')
        	render :edit 
        }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  	def set_self
	  	@person = current_user
  	end

    def user_params
      params.require(:user).permit(:avatar, :bio, :mission, :motto, :website, :place, :name, :affiliations, :email_is_public)
    end

end
