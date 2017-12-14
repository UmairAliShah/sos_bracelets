class Admin::HeightsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @height = Height.new
    @heights = Height.all
  end

  def edit
    @height = Height.find(params[:id])
  end

  def create
    @heights = Height.all
    @height = Height.new(permit_height)
    if @height.save
      redirect_to admin_heights_path
      flash[:notice] = "Height Created Successfully"
    else
      render 'index'
    end
  end

  def update
    @height = Height.find(params[:id])
    if @height.update(permit_height)
      redirect_to admin_heights_path
      flash[:notice] = "Height Updated Successfully"
    else
      render 'edit'
    end
  end

  def destroy
    @height = Height.find(params[:id])
    if @height.destroy
      redirect_to admin_heights_path
      flash[:notice] = "Height Deleted Successfully"
    else
      redirect_to admin_heights_path
      flash[:alert] = "Height Not Deleted"
    end
  end

  private
    def permit_height
      params.require(:height).permit(:name)
    end
end
