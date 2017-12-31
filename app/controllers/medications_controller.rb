class MedicationsController < ApplicationController
  before_action do
    if current_team != nil
      authenticate_team!
    else
      authenticate_user!
    end
  end


  def create
    id = params['lpid'].to_i
    n = params['name']
    dosage = params['dosage']
    frequency = params['frequency']
    notes = params['notes']
    @medication = nil

    if team_signed_in?
      @leader = current_team.leaders.find(id)
      @medication = @leader.medications.build
    elsif user_signed_in?
      @profile = current_user.profiles.find(id)
      @medication = @profile.medications.build
    end

    @medication.name = n
    @medication.dosage = dosage
    @medication.frequency = frequency
    @medication.notes = notes
    if @medication.save
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
    mid = params['mid'].to_i
    n = params['name']
    dosage = params['dosage']
    frequency = params['frequency']
    notes = params['notes']
    @medication = nil

    if team_signed_in?
      @leader = current_team.leaders.find(id)
      @medication = @leader.medications.find(mid)
    elsif user_signed_in?
      @profile = current_user.profiles.find(id)
      @medication = @profile.medications.find(mid)
    end

    @medication.name = n
    @medication.dosage = dosage
    @medication.frequency = frequency
    @medication.notes = notes
    if @medication.save
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
    @medication = Medication.find(params[:id])
    @id = @medication.medicationable_id
    @type = @medication.medicationable_type
    if @medication.destroy
      if @type == "Profile"
        redirect_to edit_user_profile_path(:id => @id)
      else
        redirect_to edit_leader_path(:id => @id)
      end
      flash[:notice] = "Medication Deleted Successfully"
    else
      if @type == "Profile"
        redirect_to edit_user_profile_path(:id => @id)
      else
        redirect_to edit_leader_path(:id => @id)
      end
      flash[:alert] = "Medication Not Deleted"
    end
  end
end
