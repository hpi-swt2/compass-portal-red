class CreateCourseTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :course_times do |t|
      t.string :weekday
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
  end
end
