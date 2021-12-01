class CreatePolylines < ActiveRecord::Migration[6.1]
  def change
    create_table :polylines do |t|

      t.timestamps
    end
  end
end
