class CreateChairs < ActiveRecord::Migration[6.1]
  def change
    create_table :chairs do |t|
      t.string :name

      t.timestamps
    end
  end
end
