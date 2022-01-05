class AddDefaultLinks < ActiveRecord::Migration[6.1]
  def change
    change_column :people, :image, :string, default: "placeholder_person.png"
    change_column :rooms, :image, :string, default: "placeholder_room.png"
  end
end
