class AddHumanVerifiedStatusToPerson < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :human_verified_status, :datetime
  end
end
