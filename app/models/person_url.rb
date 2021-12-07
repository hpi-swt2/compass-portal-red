class PersonUrl < ApplicationRecord
  validates :name, :url, presence: true, length: { minimum: 1 }
end
