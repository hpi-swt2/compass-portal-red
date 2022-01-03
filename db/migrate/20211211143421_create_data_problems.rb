class CreateDataProblems < ActiveRecord::Migration[6.1]
  def change
    create_table :data_problems do |t|
      t.string :url
      t.string :description
      t.string :field
      t.references :room, null: true, foreign_key: true
      t.references :person, null: true, foreign_key: true

      t.timestamps
    end
  end
end
