class OptionsController < ApplicationController
  def index
    # Options page
    return unless user_signed_in?

    user_id = current_user[:user_id]
    matched_people = Person.where(user_id: user_id)
    @person = matched_people[0] unless matched_people.empty?
  end
end
