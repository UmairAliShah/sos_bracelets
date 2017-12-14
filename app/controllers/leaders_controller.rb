class LeadersController < ApplicationController
  before_action do
    if current_team != nil
      authenticate_team!
    else
      authenticate_user!
    end
  end

  def index
    @leaders = current_team.leaders.all
  end

  def new
    @team = Team.find(current_team.id)
    @leader = @team.leaders.build
  end

  def show
    @leader = current_team.leaders.find(params[:id])
  end

  def show_leader
    if team_signed_in?
      @leader = current_team.leaders.find(params[:id])
    elsif user_signed_in?
      id = params[:id]
      @leader = Leader.find(id)
    end
  end

  def edit
    @leader = current_team.leaders.find(params[:id])
  end

  def create
    @team = Team.find(current_team.id)
    @leader = @team.leaders.build(permit_leader)

    code = params[:leader][:country]
    @c = ISO3166::Country.new(code)
    @country_code = "+" + @c.country_code.to_s
    @phone = params[:leader][:phone]
    @phone = @country_code.to_s + @phone.to_s
    phone = Phonelib.parse(@phone)
    @leader.code = @country_code.to_s

    if !phone.valid?
      flash[:alert] = "Please Correct Your Phone Number"
      render 'new'
    elsif phone.valid? && @leader.save
      redirect_to root_path
      flash[:notice] = "Your profile as a Leader is successfully Created"
    else
      render 'new'
    end
  end

  def update
    @leader = Leader.find(params[:id])

    code = params[:leader][:country]
    @c = ISO3166::Country.new(code)
    @country_code = "+" + @c.country_code.to_s
    @phone = params[:leader][:phone]
    @phone = @country_code.to_s + @phone.to_s
    phone = Phonelib.parse(@phone)
    @leader.code = @country_code.to_s

    if !phone.valid?
      flash[:alert] = "Please Correct Your Phone Number"
      render 'edit'
    elsif phone.valid? && @leader.update(permit_leader)
      redirect_to leaders_path
      flash[:notice] = "Leader Profile Updated Successfully"
    else
      render 'edit'
    end
  end

  def destroy
    @leader = Leader.find(params[:id])
    if @leader.destroy
      redirect_to leaders_path
      flash[:notice] = "Leader Profile Deleted Successfully"
    else
      redirect_to leaders_path
      flash[:alert] = "Leader Profile Not Deleted"
    end
  end

  private
    def permit_leader
      params.require(:leader).permit(:firstname, :lastname, :dob, :gender, :code, :country, :phone, :blood, :hair, :eye, :height, :weight, :team_id, :avatar)
    end
end
