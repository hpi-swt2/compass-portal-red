class AddCourseIdToCourseTime < ActiveRecord::Migration[6.1]
  def change
    add_column :course_times, :course_id, :integer
    add_index :course_times, :course_id
  end
end
