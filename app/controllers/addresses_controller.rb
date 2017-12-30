class AddressesController < ApplicationController

  before_action do
    if current_team != nil
      authenticate_team!
    else
      authenticate_user!
    end
  end

  def create
    lpid = params['lpid'].to_i
    line1 = params['line1']
    line2 = params['line2']
    city = params['city']
    state = params['state']
    country = params['country']
    @address = nil

    if team_signed_in?
      @leader = current_team.leaders.find(lpid)
      @address = @leader.addresses.build
    elsif user_signed_in?
      @profile = current_user.profiles.find(lpid)
      @address = @profile.addresses.build
    end

    @address.line1 = line1
    @address.line2 = line2
    @address.city = city
    @address.state = state
    @address.country = country

    if @address.save
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
    aid = params['aid'].to_i
    line1 = params['line1']
    line2 = params['line2']
    city = params['city']
    state = params['state']
    country = params['country']
    @address = nil

    if team_signed_in?
      @leader = current_team.leaders.find(lpid)
      @address = @leader.addresses.find(aid)
    elsif user_signed_in?
      @profile = current_user.profiles.find(lpid)
      @address = @profile.addresses.find(aid)
    end

    @address.line1 = line1
    @address.line2 = line2
    @address.city = city
    @address.state = state
    @address.country = country

    if @address.save
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
    @address = Address.find(params[:id])
    @id = @address.addressble_id
    @type = @address.addressble_type
    if @address.destroy
      if @type == "Profile"
        redirect_to edit_user_profile_path(:id => @id)
      else
        redirect_to edit_leader_path(:id => @id)
      end
      flash[:notice] = "Address Deleted Successfully"
    else
      if @type == "Profile"
        redirect_to edit_user_profile_path(:id => @id)
      else
        redirect_to edit_leader_path(:id => @id)
      end
      flash[:alert] = "Address Not Deleted"
    end
  end

end
