class CreateDataProblems < ActiveRecord::Migration[6.1]
  def change
    create_table :data_problems do |t|
      t.string :url
      t.string :type
      t.string :field
      t.references :rooms, null: false, foreign_key: true
      t.references :people, null: false, foreign_key: true

      t.timestamps
    end
  end
end
