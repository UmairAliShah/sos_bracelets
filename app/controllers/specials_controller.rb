class SpecialsController < ApplicationController
  before_action do
    if current_team != nil
      authenticate_team!
    else
      authenticate_user!
    end
  end


  def create
    lpid = params['lpid'].to_i
    name = params['name']
    note = params['notes']
    @special = nil

    if team_signed_in?
      @leader = current_team.leaders.find(lpid)
      @special = @leader.specials.build
    elsif user_signed_in?
      @profile = current_user.profiles.find(lpid)
      @special = @profile.specials.build
    end

    @special.name = name
    @special.notes = note

    if @special.save
      respond_to do |format|
        format.json {render json: "1"}
      end
    else
      respond_to do |format|
        format.json {render json: "-1"}
      end
    end
  end


  def update
    lpid = params['lpid'].to_i
    sid = params['sid'].to_i
    name = params['name']
    note = params['notes']
    @special = nil

    if team_signed_in?
      @leader = current_team.leaders.find(lpid)
      @special = @leader.specials.find(sid)
    elsif user_signed_in?
      @profile = current_user.profiles.find(lpid)
      @special = @profile.specials.find(sid)
    end

    @special.name = name
    @special.notes = note

    if @special.save
      respond_to do |format|
        format.json {render json: "1"}
      end
    else
      respond_to do |format|
        format.json {render json: "-1"}
      end
    end
  end

  def destroy
    @special = Special.find(params[:id])
    @id = @special.specialable_id
    @type = @special.specialable_type
    if @special.destroy
      if @type == "Profile"
        redirect_to edit_user_profile_path(:id => @id)
      else
        redirect_to edit_leader_path(:id => @id)
      end
      flash[:notice] = "Special Instruction Deleted Successfully"
    else
      if @type == "Profile"
        redirect_to edit_user_profile_path(:id => @id)
      else
        redirect_to edit_leader_path(:id => @id)
      end
      flash[:alert] = "Special Instruction Not Deleted"
    end
  end
end
