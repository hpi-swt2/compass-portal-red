class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.string :email
      t.string :last_name
      t.string :first_name
      t.string :title
      t.string :image
      t.string :status

      t.timestamps
    end
  end
end
