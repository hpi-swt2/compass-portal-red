class CreateInformation < ActiveRecord::Migration[6.1]
  def change
    create_table :information do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
