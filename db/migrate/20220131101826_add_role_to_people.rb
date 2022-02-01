class AddRoleToPeople < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :role, :string
  end
end
