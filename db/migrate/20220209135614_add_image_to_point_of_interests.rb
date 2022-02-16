class AddImageToPointOfInterests < ActiveRecord::Migration[6.1]
  def change
    add_column :point_of_interests, :image, :string, default: "placeholder_poi.png"
  end
end
