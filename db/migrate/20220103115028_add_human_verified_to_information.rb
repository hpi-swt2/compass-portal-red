class AddHumanVerifiedToInformation < ActiveRecord::Migration[6.1]
  def change
    add_column :information, :human_verified, :datetime
  end
end
