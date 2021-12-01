class AddPolylineToRooms < ActiveRecord::Migration[6.1]
  def change
    add_reference :rooms, :outer_shape, null: false, foreign_key: { to_table: :polylines }
  end
end
