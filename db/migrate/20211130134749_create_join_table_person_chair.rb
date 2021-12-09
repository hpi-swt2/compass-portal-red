class CreateJoinTablePersonChair < ActiveRecord::Migration[6.1]
  def change
    create_join_table :people, :chairs do |t|
      # t.index [:person_id, :chair_id]
      # t.index [:chair_id, :person_id]
    end
  end
end
