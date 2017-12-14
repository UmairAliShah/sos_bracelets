class Admin::HairsController < ApplicationController
  def index
    @hairs = Hair.all
    @hair = Hair.new
  end

  def edit
    @hair = Hair.find(params[:id])
  end

  def create
    @hairs = Hair.all
    @hair = Hair.new(permit_hairs)
    if @hair.save
      redirect_to admin_hairs_path
      flash[:notice] = "Hair Color Created Successfully"
    else
      render 'index'
    end
  end

  def update
    @hair = Hair.find(params[:id])
    if @hair.update(permit_hairs)
      redirect_to admin_hairs_path
      flash[:notice] = "Hair Color Updated Successfully"
    else
      render 'edit'
    end
  end

  def destroy
    @hair = Hair.find(params[:id])
    if @hair.destroy
      redirect_to admin_hairs_path
      flash[:notice] = "Hair Color Deleted Successfully"
    else
      redirect_to admin_hairs_path
      flash[:alert] = "Hair Color Not Deleted"
    end
  end

  private
    def permit_hairs
      params.require(:hair).permit(:name)
    end
end
