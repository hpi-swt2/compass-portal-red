class CreatePointOfInterests < ActiveRecord::Migration[6.1]
  def change
    create_table :point_of_interests do |t|
      t.references :point, null: false, foreign_key: true

      t.timestamps
    end
  end
end
