class DataProblemsAllowNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :data_problems, :rooms_id, true
    change_column_null :data_problems, :people_id, true
  end
end
