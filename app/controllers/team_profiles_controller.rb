class TeamProfilesController < ApplicationController
  before_action do
    if current_team != nil
      authenticate_team!
    else
      authenticate_user!
    end
  end

  def index
    @profiles = []
    if team_signed_in?
      if current_team.team_profiles.count == 0
        redirect_to new_team_profile_path
        flash[:notice] = "You need to create Your team profile first"
      else
        @profiles = current_team.team_profiles.all
      end
    elsif user_signed_in?
      @user_profiles = current_user.profiles
      @user_profiles.each do |up|
        @profiles << up.team_profile
      end
    end
  end

  def show
    @team_profile = TeamProfile.find(params[:id])
  end

  def new
      @team = Team.find(current_team.id)
      @team_profile = @team.team_profiles.build
  end

  def edit
    @leaders = current_team.leaders
    @team_profile = TeamProfile.find(params[:id])
  end

  def create
    @team = Team.find(current_team.id)
    @team_profile = @team.team_profiles.build(permit_params)
    if @team_profile.save
      redirect_to new_leader_path(id: @team_profile.id)
      flash[:notice] = "Team Profile is Created Successfully"
    else
      render 'new'
    end
  end

  def update
    @leaders = current_team.leaders
    @team_profile = TeamProfile.find(params[:id])
    @members = params['team_profile']['members'].to_i
    if @members > @team_profile.members
      @members = @members - @team_profile.members
      @members.times do |t|
        @team_profile.invitations.create(email: "")
      end
    end
    if @team_profile.update(permit_params)
      redirect_to root_path
      flash[:notice] = "Team Profile Updated Successfully"
    else
      render 'edit'
    end
  end

  def destroy
    @team_profile = TeamProfile.find(params[:id])
    if @team_profile.destroy
      redirect_to root_path
      flash[:notice] = "Team Profile Deleted"
    else
      redirect_to root_path
      flash[:alert] = "Team Profile Not Deleted"
    end
  end

  private
    def permit_params
      params.require(:team_profile).permit(:name, :avatar, :city, :zip, :state, :country, :team_id, :members)
    end
end
