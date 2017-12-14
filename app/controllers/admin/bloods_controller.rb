class Admin::BloodsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @blood = Blood.new
    @bloods = Blood.all
  end

  def edit
    @blood = Blood.find(params[:id])
  end

  def create
    @bloods = Blood.all
    @blood = Blood.new(permit_blood)
    if @blood.save
      redirect_to admin_bloods_path
      flash[:notice] = "Blood Group Created Successfully"
    else
      render 'index'
    end
  end

  def update
    @blood = Blood.find(params[:id])
    if @blood.update(permit_blood)
      redirect_to admin_bloods_path
      flash[:notice] = "Blood Group Updated Successfully"
    else
      render 'edit'
    end
  end

  def destroy
    @blood = Blood.find(params[:id])
    if @blood.destroy
      redirect_to admin_bloods_path
      flash[:notice] = "Blood Group Deleted Successfully"
    else
      redirect_to admin_bloods_path
      flash[:alert] = "Blood Group Not Deleted"
    end
  end

  private
    def permit_blood
      params.require(:blood).permit(:name)
    end
end
