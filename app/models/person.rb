class Person < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :informations
  has_and_belongs_to_many :chairs
  belongs_to :room, optional: true

  def name
    "#{first_name} #{last_name}"
  end

  def full_name
    "#{title} #{name}"
  end
end
