class Users::SessionsController < Devise::SessionsController
  prepend_before_action :redirect_if_logged_in, only: :new

  # rubocop needs to be disabled here because otherwise he will throw another error
  # rubocop:disable Lint/UselessMethodDefinition
  def new
    super
  end
  # rubocop:enable Lint/UselessMethodDefinition

  def redirect_if_logged_in
    assert_is_devise_resource!
    return unless is_navigational_format?

    no_input = devise_mapping.no_input_strategies
    authenticated = get_authenticated(no_input)
    return unless authenticated && warden.user(resource_name)

    redirect_to search_path
  end

  def get_authenticated(no_input)
    if no_input.present?
      args = no_input.dup.push scope: resource_name
      warden.authenticate?(*args)
    else
      warden.authenticated?(resource_name)
    end
  end
end
