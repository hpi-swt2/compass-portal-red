class OptionsController < ApplicationController
  def index
    # Options page 
    if user_signed_in? 
     
      user_id = current_user[:user_id ]
      matched_people = Person.where(user_id: user_id)
      if !matched_people.empty? 
        @person = matched_people[0]
        @person.image = "/assets/images/people/csm_hpi-ite_valeska-maul_b80b438045.jpg"
      end
    end
  end
end