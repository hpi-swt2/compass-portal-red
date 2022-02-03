class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :module_category
      t.datetime :exam_date

      t.timestamps
    end
  end
end
