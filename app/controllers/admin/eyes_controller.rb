class Admin::EyesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @eye = Eye.new
    @eyes = Eye.all
  end

  def edit
    @eye = Eye.find(params[:id])
  end

  def create
    @eye = Eye.new(permit_eye)
    @eyes = Eye.all
    if @eye.save
      redirect_to admin_eyes_path
      flash[:notice] = "Eye Color Created Successfully"
    else
      render 'index'
    end
  end

  def update
    @eye = Eye.find(params[:id])
    if @eye.update(permit_eye)
      redirect_to admin_eyes_path
      flash[:notice] = "Eye Color Updated Successfully"
    else
      render 'edit'
    end
  end

  def destroy
    @eye = Eye.find(params[:id])
    if @eye.destroy
      redirect_to admin_eyes_path
      flash[:notice] = "Eye Color Deleted Successfully"
    else
      redirect_to admin_eyes_path
      flash[:alert] = "Eye Color Not Deleted"
    end
  end

  private
    def permit_eye
      params.require(:eye).permit(:name)
    end
end
