class CreateEmailLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :email_log do |t|
      t.text :email_address
      t.date :last_sent

      t.timestamps
    end
  end
end
