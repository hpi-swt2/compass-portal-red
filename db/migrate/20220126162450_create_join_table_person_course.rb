class CreateJoinTablePersonCourse < ActiveRecord::Migration[6.1]
  def change
    create_join_table :people, :courses do |t|
      # t.index [:person_id, :course_id]
      # t.index [:course_id, :person_id]
    end
  end
end
