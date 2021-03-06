class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
        if @user.confirmed?
          sign_in_and_redirect @user, :event => :authentication
        else
          redirect_to new_user_credential_path(id: @user.id)
        end
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
