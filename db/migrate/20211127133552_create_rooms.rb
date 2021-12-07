class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :number
      t.string :floor
      t.string :full_name

      t.timestamps
    end
  end
end
