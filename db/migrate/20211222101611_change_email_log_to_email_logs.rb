class ChangeEmailLogToEmailLogs < ActiveRecord::Migration[6.1]
  def change
    rename_table :email_log, :email_logs
  end
end
