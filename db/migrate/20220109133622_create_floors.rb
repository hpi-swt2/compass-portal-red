class CreateFloors < ActiveRecord::Migration[6.1]
  def change
    create_table :floors do |t|
      t.string :name

      t.timestamps
    end
  end
end
