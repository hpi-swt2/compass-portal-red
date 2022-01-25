class AddNameToPointOfInterests < ActiveRecord::Migration[6.1]
  def change
    add_column :point_of_interests, :name, :string
  end
end
