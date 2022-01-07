class OptionsController < ApplicationController
  def index
    # Options page 
    if user_signed_in? 
      user_id = current_user[:user_id ]
      # TODO: remove person creation
      Person.create!(user_id: user_id, first_name: "Peter", last_name:"Maffay")
      matched_people = Person.where(user_id: user_id)
      if !matched_people.empty? 
        @person = matched_people[0]
      end
    end
  end
end