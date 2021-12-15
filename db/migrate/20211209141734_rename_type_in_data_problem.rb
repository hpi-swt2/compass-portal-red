class RenameTypeInDataProblem < ActiveRecord::Migration[6.1]
  def self.up
    rename_column :data_problems, :type, :description
  end
end
