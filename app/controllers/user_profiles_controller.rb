class UserProfilesController < ApplicationController
  before_action do
    if current_team != nil
      authenticate_team!
    else
      authenticate_user!
    end
  end

  def index
    @profiles = current_user.profiles.all
  end

  def new
    id = params[:id]
    invitation_id = params[:invitation_id]
    @team_profile = TeamProfile.find(id)
    @profile = current_user.profiles.build
    @invitation = Invitation.find(invitation_id)
  end

  def edit
    id = params[:id]
    @profile = current_user.profiles.find(id)
  end

  def show
    id = params[:id]
    @profile = current_user.profiles.find(id)
  end

  def show_user_profile
    id = params[:id]
    @profile = Profile.find(id)
  end

  def create
    id = params[:id]
    @team_profile = TeamProfile.find(id)
    invitation_id = params[:invitation_id]
    @invitation = Invitation.find(invitation_id)

    @user = User.find(current_user.id)
    @profile = @user.profiles.build(permit_profile)

    code = params[:profile][:country]
    @c = ISO3166::Country.new(code)
    @country_code = "+" + @c.country_code.to_s
    @phone = params[:profile][:phone]
    @phone = @country_code.to_s + @phone.to_s
    phone = Phonelib.parse(@phone)
    @profile.code = @country_code.to_s
    @profile.team_profile_id = @team_profile.id

    if !phone.valid?
      flash[:alert] = "Please Correct Your Phone Number"
      render 'new'
    elsif phone.valid? && @profile.save
      @invitation.destroy
      redirect_to root_path
      flash[:notice] = "Your profile is successfully Created"
    else
      render 'new'
    end
  end

  def update
    id = params[:id]
    @profile = current_user.profiles.find(id)

    code = params[:profile][:country]
    @c = ISO3166::Country.new(code)
    @country_code = "+" + @c.country_code.to_s
    @phone = params[:profile][:phone]
    @phone = @country_code.to_s + @phone.to_s
    phone = Phonelib.parse(@phone)
    @profile.code = @country_code.to_s

    if !phone.valid?
      flash[:alert] = "Please Correct Your Phone Number"
      render 'edit'
    elsif phone.valid? && @profile.update(permit_profile)
      redirect_to user_profiles_path
      flash[:notice] = "Your profile is Updated successfully"
    else
      render 'edit'
    end
    #debugger
  end

  def destroy

  end


  private
    def permit_profile
      params.require(:profile).permit(:firstname, :lastname, :dob, :gender, :code, :country, :phone, :blood, :hair, :eye, :height, :weight, :team_profile_id, :avatar, :user_id)
    end
end
