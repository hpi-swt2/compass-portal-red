json.extract! data_problem, :id, :url, :type, :field, :rooms_id, :people_id, :created_at, :updated_at
json.url data_problem_url(data_problem, format: :json)
