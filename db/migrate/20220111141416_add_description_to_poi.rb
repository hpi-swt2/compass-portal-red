class AddDescriptionToPoi < ActiveRecord::Migration[6.1]
  def change
    add_column :point_of_interests, :description, :string, null: true
  end
end
