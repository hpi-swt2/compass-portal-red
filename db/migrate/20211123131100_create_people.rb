class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.string :name
      t.string :surname
      t.string :title
      t.string :email
      t.string :phone
      t.string :office
      t.string :website
      t.string :image
      t.string :chair
      t.string :office_hours
      t.string :telegram_handle
      t.string :knowledge

      t.timestamps
    end
  end
end
