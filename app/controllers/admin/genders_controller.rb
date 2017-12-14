class Admin::GendersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @gender = Gender.new
    @genders = Gender.all
  end

  def edit
    @gender = Gender.find(params[:id])
  end

  def create
    @genders = Gender.all
    @gender = Gender.new(permit_gender)
    if @gender.save
      redirect_to admin_genders_path
      flash[:notice] = "Gender Created Successfully"
    else
      render 'index'
    end
  end

  def update
    @gender = Gender.find(params[:id])
    if @gender.update(permit_gender)
      redirect_to admin_genders_path
      flash[:notice] = "Gender Updated Successfully"
    else
      render 'edit'
    end
  end

  def destroy
    @gender = Gender.find(params[:id])
    if @gender.destroy
      redirect_to admin_genders_path
      flash[:notice] = "Gender Deleted Successfully"
    else
      redirect_to admin_genders_path
      flash[:alert] = "Gender Not Deleted"
    end
  end

  private
    def permit_gender
      params.require(:gender).permit(:name)
    end
end
