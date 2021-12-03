class Building < ApplicationRecord
  has_many :rooms, dependent: :nullify
end
