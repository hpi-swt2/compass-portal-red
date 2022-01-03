class Information < ApplicationRecord
  validates :value, presence: true
  validates :key, presence: true

  belongs_to :person

  def self.get_value(key)
    where(key: key)&.first&.value
  end
end
