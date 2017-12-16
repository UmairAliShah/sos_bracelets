class UserCredentialsController < ApplicationController

  def new
    id = params[:id]
    @user = User.find(id)
  end

  def create
    #debugger
    id = params[:id]
    @user = User.find(id)
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      redirect_to root_path
      flash[:notice] = "A confirmation E-mail has been sent to Your account. Please Confirm Your account"
    else
      render 'new'
    end
  end


  private
    def permit_user
      params.require(:user).permit(:name, :email, :image, :password, :password_confirmation, :uid, :provider)
    end
end
