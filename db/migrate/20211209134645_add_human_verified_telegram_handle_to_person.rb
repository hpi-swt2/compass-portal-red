class AddHumanVerifiedTelegramHandleToPerson < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :human_verified_telegram_handle, :datetime
  end
end
