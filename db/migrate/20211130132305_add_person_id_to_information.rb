class AddPersonIdToInformation < ActiveRecord::Migration[6.1]
  def change
    add_column :information, :person_id, :integer
    add_index :information, :person_id
  end
end
