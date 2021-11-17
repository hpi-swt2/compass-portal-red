class Users::RegistrationsController < Devise::RegistrationsController

  protected

  # Users signed in with OpenID Connect don't have a password set
  # Allow changing user details (except passwords) without knowledge of the current pw
  # https://stackoverflow.com/questions/43216712/require-password-only-when-changing-password-devise-registration
  def update_resource(resource, params)
    # Require current password if user is trying to change password, normal devise functionality
    return super if params["password"]&.present?

    # Allows users to update user details without password.
    resource.update_without_password(params.except("current_password"))
  end
end
  