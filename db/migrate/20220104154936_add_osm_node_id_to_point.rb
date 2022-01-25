class AddOsmNodeIdToPoint < ActiveRecord::Migration[6.1]
  def change
    add_column :points, :osm_node_id, :integer
  end
end
