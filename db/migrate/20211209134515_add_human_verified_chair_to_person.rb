class AddHumanVerifiedChairToPerson < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :human_verified_chair, :datetime
  end
end
