class AddHumanVerifiedFirstNameToPerson < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :human_verified_first_name, :datetime
  end
end
