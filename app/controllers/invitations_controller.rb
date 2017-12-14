class InvitationsController < ApplicationController
  before_action :authenticate_team!

  def new
    @invitations = []
    id = params[:id]
    @team_profile = current_team.team_profiles.find(id)
    @team_profile.members.times do
      @invitations << @team_profile.invitations.build
    end
  end

  def create
    id = params[:id]
    @team_profile = current_team.team_profiles.find(id)
    count = @team_profile.members - 1
    params["invitations"].each do |invitation|
      @in = @team_profile.invitations.create(email: params["invitations"][count][:email])
      InviteMailer.invitation_send(@in).deliver_later!(wait: 1.minute)
      count = count - 1
    end
    redirect_to root_path
    flash[:notice] = "Inviation send to Your friends Successfully"
  end


  def send_invite
    #debugger
    id = params[:id]
    @team_profile = current_team.team_profiles.find(id)
    @team_profile.invitations.each do |i|
      InviteMailer.invitation_send(i).deliver_later!(wait: 1.minute)
    end
    redirect_to root_path
    flash[:notice] = "Inviation send to Your friends Successfully"
  end
end
