class SearchableRecord < ApplicationRecord
  self.abstract_class = true

  def searchable_attributes
    []
  end

  def to_string
    raise 'This method should be overriden to display a string when searching'
  end

  def self.search(query)
    where("first_name like ?", "%#{query}%")
  end
end
