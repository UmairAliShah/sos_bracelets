class MedicalConditionsController < ApplicationController
  before_action do
    if current_team != nil
      authenticate_team!
    else
      authenticate_user!
    end
  end

  def create
    id = params['id'].to_i
    c = params['condition']
    notes = params['notes']
    @condition = nil

    if team_signed_in?
      @leader = current_team.leaders.find(id)
      @condition = @leader.medical_conditions.build
    elsif user_signed_in?
      @profile = current_user.profiles.find(id)
      @condition = @profile.medical_conditions.build
    end

    @condition.condition = c
    @condition.note = notes
    if @condition.save
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
    cid = params['cid'].to_i
    c = params['condition']
    notes = params['notes']
    @condition = nil

    if team_signed_in?
      @leader = current_team.leaders.find(id)
      @condition = @leader.medical_conditions.find(cid)
    elsif user_signed_in?
      @profile = current_user.profiles.find(id)
      @condition = @profile.medical_conditions.find(cid)
    end

    @condition.condition = c
    @condition.note = notes
    if @condition.save
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
    @condition = MedicalCondition.find(params[:id])
    @id = @condition.conditionable_id
    @type = @condition.conditionable_type    
    if @condition.destroy
      if @type == "Profile"
        redirect_to edit_user_profile_path(:id => @id)
      else
        redirect_to edit_leader_path(:id => @id)
      end
      flash[:notice] = "Medical Condition Deleted Successfully"
    else
      if @type == "Profile"
        redirect_to edit_user_profile_path(:id => @id)
      else
        redirect_to edit_leader_path(:id => @id)
      end
      flash[:alert] = "Medical Condition Not Deleted"
    end
  end
end
