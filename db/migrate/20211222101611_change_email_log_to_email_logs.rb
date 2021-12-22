class ChangeEmailLogToEmailLogs < ActiveRecord::Migration[6.1]
  def change
    rename_column :table, :old_column, :new_column
  end
end
