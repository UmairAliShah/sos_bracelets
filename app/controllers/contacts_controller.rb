class ContactsController < ApplicationController
  before_action do
    if current_team != nil
      authenticate_team!
    else
      authenticate_user!
    end
  end

  def create
    profile_id = params['profile_id'].to_i
    name = params['name']
    country = params['country']
    number = params['number']
    n = number
    relation = params['relation']
    email = params['email']
    @contact = nil

    if team_signed_in?
      @leader = current_team.leaders.find(profile_id)
      @contact = @leader.contacts.build
    elsif user_signed_in?
      @profile = current_user.profiles.find(profile_id)
      @contact = @profile.contacts.build
    end

    @c = ISO3166::Country.new(country)
    @country_code = @c.country_code.to_s

    number = @country_code.to_s + number.to_s
    @phone = Phonelib.parse(number)

    @contact.name = name
    @contact.country = country
    @contact.code = @country_code
    @contact.number = n
    @contact.relation = relation
    @contact.email = email

    if !@phone.valid?
      respond_to do |format|
        format.json {render json: "-1"}
      end
    elsif @phone.valid? && @contact.save
      respond_to do |format|
        format.json {render json: "1"}
      end
    end
  end


  def update
    profile_id = params['profile_id'].to_i
    cid = params['cid'].to_i
    name = params['name']
    country = params['country']
    number = params['number']
    n = number
    relation = params['relation']
    email = params['email']
    @contact = nil

    if team_signed_in?
      @leader = current_team.leaders.find(profile_id)
      @contact = @leader.contacts.find(cid)
    elsif user_signed_in?
      @profile = current_user.profiles.find(profile_id)
      @contact = @profile.contacts.find(cid)
    end

    @c = ISO3166::Country.new(country)
    @country_code = @c.country_code.to_s

    number = @country_code.to_s + number.to_s
    @phone = Phonelib.parse(number)

    @contact.name = name
    @contact.country = country
    @contact.code = @country_code
    @contact.number = n
    @contact.relation = relation
    @contact.email = email

    if !@phone.valid?
      respond_to do |format|
        format.json {render json: "-1"}
      end
    elsif @phone.valid? && @contact.save
      respond_to do |format|
        format.json {render json: "1"}
      end
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @id = @contact.contactable_id
    if @contact.destroy
      @type = @contact.contactable_type
      if @type == "Profile"
        redirect_to edit_user_profile_path(:id => @id)
      else
        redirect_to edit_leader_path(:id => @id)
      end
      flash[:notice] = "Emergency Contact Deleted Successfully"
    else
      redirect_to edit_user_profile_path(:id => @id)
      flash[:alert] = "Emergency Contact Not Deleted"
    end
  end
  private
    def permit_leader
      params.require(:contact).permit(:name, :number, :country, :code, :email, :profile_id)
    end
end
