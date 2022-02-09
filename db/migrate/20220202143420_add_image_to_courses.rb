class AddImageToCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :image, :string, default: "placeholder_course.png"
  end
end
