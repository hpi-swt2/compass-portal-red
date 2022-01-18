class AddPointTypeToPointOfInterests < ActiveRecord::Migration[6.1]
  def change
    add_column :point_of_interests, :point_type, :string, null: false
  end
end
