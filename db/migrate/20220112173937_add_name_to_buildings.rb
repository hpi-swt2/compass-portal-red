class AddNameToBuildings < ActiveRecord::Migration[6.1]
  def change
    add_column :buildings, :name, :string, null: false
  end
end
