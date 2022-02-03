json.extract! course, :id, :name, :module_category, :exam_date, :created_at, :updated_at
json.url course_url(course, format: :json)
