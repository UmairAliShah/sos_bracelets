class AllergiesController < ApplicationController
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
    @allergy = nil

    if team_signed_in?
      @leader = current_team.leaders.find(lpid)
      @allergy = @leader.allergies.build
    elsif user_signed_in?
      @profile = current_user.profiles.find(lpid)
      @allergy = @profile.allergies.build
    end

    @allergy.name = name
    @allergy.note = note

    if @allergy.save
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
    id = params['lpid'].to_i
    aid = params['aid'].to_i
    n = params['name']
    notes = params['notes']
    @allergy = nil

    if team_signed_in?
      @leader = current_team.leaders.find(id)
      @allergy = @leader.allergies.find(aid)
    elsif user_signed_in?
      @profile = current_user.profiles.find(id)
      @allergy = @profile.allergies.find(aid)
    end

    @allergy.name = n
    @allergy.note = notes
    if @allergy.save
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
    #debugger
    @allergy = Allergy.find(params[:id])
    @id = @allergy.allergable_id
    @type = @allergy.allergable_type
    if @allergy.destroy
      if @type == "Profile"
        redirect_to edit_user_profile_path(:id => @id)
      else
        redirect_to edit_leader_path(:id => @id)
      end
      flash[:notice] = "Allergy Deleted Successfully"
    else
      if @type == "Profile"
        redirect_to edit_user_profile_path(:id => @id)
      else
        redirect_to edit_leader_path(:id => @id)
      end
      flash[:alert] = "Allergy Not Deleted"
    end
  end
end
