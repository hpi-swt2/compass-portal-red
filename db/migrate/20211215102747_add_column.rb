class AddColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :email_log, :people_id, :integer
  end
end
