class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # See https://github.com/omniauth/omniauth/wiki/FAQ#rails-session-is-clobbered-after-callback-on-developer-strategy
  skip_before_action :verify_authenticity_token, only: :openid_connect

  def openid_connect
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      # devise helper: https://www.rubydoc.info/github/plataformatec/devise/DeviseController:set_flash_message
      set_flash_message(:notice, :success, kind: 'OpenID Connect', reason: 'HPI OIDC login')  
    else
      # Removing extra as it can overflow some session stores
      session["devise.openid_connect_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_registration_url
    end
  end

  def failure
    set_flash_message(:alert, :failure, kind: 'OpenID Connect', reason: 'HPI OIDC login')
    redirect_to root_path
  end
end
