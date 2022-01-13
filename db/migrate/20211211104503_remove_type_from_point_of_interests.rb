class RemoveTypeFromPointOfInterests < ActiveRecord::Migration[6.1]
  def change
    remove_column :point_of_interests, :type, :string
  end
end
