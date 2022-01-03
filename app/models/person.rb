# The model representing a person associated with the HPI
class Person < SearchableRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :informations, dependent: :destroy, autosave: true
  has_and_belongs_to_many :chairs
  belongs_to :room, optional: true, dependent: :destroy
  belongs_to :user, optional: true, dependent: :destroy

  def name
    "#{first_name} #{last_name}"
  end

  def full_name
    "#{title} #{name}"
  end

  def to_string
    full_name
  end

  def self.searchable_attributes
    %w[title first_name last_name]
  end
end
