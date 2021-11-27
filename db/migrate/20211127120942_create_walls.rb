class CreateWalls < ActiveRecord::Migration[6.1]
  def change
    create_table :walls do |t|

      t.timestamps
    end
  end
end
