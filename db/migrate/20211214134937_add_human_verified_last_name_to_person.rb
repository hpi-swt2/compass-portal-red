class AddHumanVerifiedLastNameToPerson < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :human_verified_last_name, :datetime
  end
end
