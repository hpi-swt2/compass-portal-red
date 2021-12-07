class CreateBuildings < ActiveRecord::Migration[6.1]
  def change
    create_table :buildings, &:timestamps
  end
end
