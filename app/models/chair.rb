# The model representing a chair at the HPI
class Chair < SearchableRecord
  validates :name, presence: true

  has_and_belongs_to_many :people
  has_and_belongs_to_many :rooms

  def to_string
    name
  end

  def self.searchable_attributes
    ["name"]
  end
end
