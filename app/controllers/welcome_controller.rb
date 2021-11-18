class WelcomeController < ApplicationController
  # https://github.com/heartcombo/devise#controller-filters-and-helpers
  before_action :authenticate_user!, only: [:protected]
  # Alternative: before_action :authenticate_user!, :except => [:index]

  def index
    # Welcome page, accessible without login
  end

  def protected
    # Only accessible by logged in users, see `before_action` call
  end
end
