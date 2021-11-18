class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # See https://github.com/omniauth/omniauth/wiki/FAQ#rails-session-is-clobbered-after-callback-on-developer-strategy
  skip_before_action :verify_authenticity_token, only: :openid_connect

  # https://github.com/heartcombo/devise/wiki/OmniAuth:-Overview
  def openid_connect
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
    # devise helper: https://www.rubydoc.info/github/plataformatec/devise/DeviseController:set_flash_message
    set_flash_message(:notice, :success, kind: 'OpenID Connect', reason: 'HPI OIDC login')  
    # In case more input is required to save user object, return new user from `User.from_omniauth`
    # and redirect to new_user_registration_url with gathered OpenID data:
    # session["devise.openid_connect_data"] = request.env["omniauth.auth"].except(:extra)
  end

  def failure
    set_flash_message(:alert, :failure, kind: 'OpenID Connect', reason: 'HPI OIDC login')
    redirect_to root_path
  end
end
