# The base class for all searchable models
class SearchableRecord < ApplicationRecord
  self.abstract_class = true

  def self.searchable_attributes
    []
  end

  def self.searchable_relations
    joins([])
  end

  def to_string
    raise 'This method should be overriden to display a string when searching'
  end

  def icon_class
    "search-item-icon --#{self.class.name.downcase}"
  end

  def self.search(query)
    attributes = searchable_attributes.map { |attribute| "#{attribute} like '%#{query}%'" }
    search_string = attributes.join(" or ")
    searchable_relations.where(search_string).group(:id)
  end
end
