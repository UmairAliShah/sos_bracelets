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

    contact_code = params[:profile][:contact][:country]
    @contact_c = ISO3166::Country.new(contact_code)
    @contact_country_code = "+" + @contact_c.country_code.to_s
    @number = params[:profile][:contact][:number]
    @number = @contact_country_code.to_s + @number.to_s
    contact_phone = Phonelib.parse(@number)

    if !phone.valid?
      flash[:alert] = "Please Correct Your Phone Number"
      render 'new'
    elsif !contact_phone.valid?
      flash[:alert] = "Please Correct Your Emergency Contact Phone Number"
      render 'new'
    elsif phone.valid? && @profile.save
      @contact = @profile.contacts.build
      @contact.name = params[:profile][:contact][:name]
      @contact.relation = params[:profile][:contact][:relation]
      @contact.country = params[:profile][:contact][:country]
      @contact.code = @contact_country_code
      @contact.number = params[:profile][:contact][:number]
      @contact.email = params[:profile][:contact][:email]
      @contact.save

      @address = @profile.addresses.build
      @address.line1 = params[:profile][:address][:line1]
      @address.line2 = params[:profile][:address][:line2]
      @address.country = params[:profile][:address][:country]
      @address.city = params[:profile][:address][:city]
      @address.state = params[:profile][:address][:state]
      @address.save

      @medical_condition = @profile.medical_conditions.build
      @medical_condition.condition = params[:profile][:medical_condition][:condition]
      @medical_condition.note = params[:profile][:medical_condition][:note]
      @medical_condition.save

      @allergy = @profile.allergies.build
      @allergy.name = params[:profile][:allergy][:name]
      @allergy.note = params[:profile][:allergy][:note]
      @allergy.save

      @medication = @profile.medications.build
      @medication.name = params[:profile][:medication][:name]
      @medication.dosage = params[:profile][:medication][:dosage]
      @medication.name = params[:profile][:medication][:name]
      @medication.name = params[:profile][:medication][:name]
      @medication.save

      @special = @profile.specials.build
      @special.name = params[:profile][:special][:name]
      @special.notes = params[:profile][:special][:notes]
      @special.save
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
  end

  def destroy

  end

  def member_profile
    id = params[:id]
    @team_profile = TeamProfile.find(id)
  end

  private
    def permit_profile
      params.require(:profile).permit(:firstname, :lastname, :dob, :gender, :code, :country, :phone, :blood, :hair, :eye, :height, :weight, :team_profile_id, :avatar, :user_id,
                                      addresses: [:id, :line1, :line2, :city, :state, :country, :addressble_type, :addressble_id],
                                      allergies: [:id, :name, :note, :allergable_type, :allergable_id],
                                      contacts: [:id, :name, :relation, :country, :code, :number, :email, :contactable_type, :contactable_id],
                                      medical_conditions: [:id, :condition, :note, :conditionable_type, :conditionable_id],
                                      medications: [:id, :name, :dosage, :frequency, :notes, :medicationable_type, :medicationable_id],
                                      specials: [:id, :name, :notes, :specialable_type, :specialable_id]
                                    )
    end
end
