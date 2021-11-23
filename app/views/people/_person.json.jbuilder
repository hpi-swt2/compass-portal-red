json.extract! person, :id, :name, :surname, :title, :email, :phone, :office, :website, :image, :chair, :office_hours, :telegram_handle, :knowledge, :created_at, :updated_at
json.url person_url(person, format: :json)
