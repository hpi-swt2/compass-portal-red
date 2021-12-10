# The base class for all searchable models
class SearchableRecord < ApplicationRecord
  self.abstract_class = true

  def self.searchable_attributes
    []
  end

  def to_string
    raise 'This method should be overriden to display a string when searching'
  end

  def self.search(query)
    attributes = searchable_attributes.map { |attribute| "#{attribute} like \"%#{query}%\"" }
    search_string = attributes.join(" or ")
    where(search_string)
  end
end
