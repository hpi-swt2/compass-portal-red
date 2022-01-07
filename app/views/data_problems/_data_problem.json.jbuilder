json.extract! data_problem, :id, :url, :description, :field, :room_id, :person_id, :created_at, :updated_at
json.url data_problem_url(data_problem, format: :json)
