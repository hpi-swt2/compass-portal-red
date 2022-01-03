class Information < ApplicationRecord
  validates :value, presence: true
  validates :key, presence: true

  belongs_to :person

  def self.get_value(key)
    where(key: key)&.first&.value
  end

  def self.get_human_verified(key)
    where(key: key)&.first&.human_verified
  end
end
