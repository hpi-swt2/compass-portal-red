class AddFloorsToBuilding < ActiveRecord::Migration[6.1]
  def change
    add_reference :floors, :building, null: false, foreign_key: true
  end
end
