class CreatePoints < ActiveRecord::Migration[6.1]
  def change
    create_table :points do |t|
      t.float :x
      t.float :y

      t.timestamps
    end
  end
end
