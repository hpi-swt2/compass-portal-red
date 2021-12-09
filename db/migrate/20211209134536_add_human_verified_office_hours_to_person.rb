class AddHumanVerifiedOfficeHoursToPerson < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :human_verified_office_hours, :datetime
  end
end
