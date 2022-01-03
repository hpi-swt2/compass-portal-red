json.extract! person_url, :id, :name, :url, :created_at, :updated_at
json.url person_url_url(person_url, format: :json)
