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
    begin
      id = params['pidI']
      @list = params['listI']

      @team_profile = current_team.team_profiles.find(id)
      @invitations = @team_profile.invitations

      @list.each do |l|
        @id = l.to_s.split('=')[0]
        @email = l.to_s.split('=')[1]
        @invite = @team_profile.invitations.find(@id)
        if @invite.email == @email
          InviteMailer.invitation_send(@invite).deliver_later!(wait: 1.minute)
        else
          @invite.email = @email
          if @invite.save
            InviteMailer.invitation_send(@invite).deliver_later!(wait: 1.minute)
          end
        end
      end
      respond_to do |format|
        format.json {render json: "1"}
      end
    rescue
      respond_to do |format|
        format.json {render json: "-2"}
      end
    end
  end
end
