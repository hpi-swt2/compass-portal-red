class AddImageToChairs < ActiveRecord::Migration[6.1]
  def change
    add_column :chairs, :image, :string, default: "placeholder_chair.png"
  end
end
