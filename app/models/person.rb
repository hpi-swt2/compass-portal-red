class Person < ApplicationRecord
  has_many :data_problems, dependent: :delete_all
end
