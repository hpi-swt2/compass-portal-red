class AddIsAdminToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :isAdmin, :boolean
  end
end
