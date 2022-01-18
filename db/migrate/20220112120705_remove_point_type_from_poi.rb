class RemovePointTypeFromPoi < ActiveRecord::Migration[6.1]
  def change
    remove_column :point_of_interests, :point_type, :string
  end
end
