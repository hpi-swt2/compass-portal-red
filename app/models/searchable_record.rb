# The base class for all searchable models
class SearchableRecord < ApplicationRecord
  self.abstract_class = true

  def self.searchable_attributes
    []
  end

  def self.searchable_relations
    []
  end

  def displayed_tags
    []
  end

  def image_or_placeholder
    image
  end

  def to_s
    raise 'This method should be overriden to display a string when searching'
  end

  def icon_class
    "search-item-icon --#{self.class.name.downcase}"
  end

  def related_searchable_records
    []

  def self.search_string(query)
    like_operator = ActiveRecord::Base.connection.adapter_name == "SQLite" ? "like" : "ilike"
    attributes = searchable_attributes.map { |attribute| "#{attribute} " + like_operator + " '%#{query}%'" }
    attributes.join(" or ")

  end

  def self.search(query)
    join = left_outer_joins(searchable_relations)
    if query.strip.casecmp(name).zero?
      join.group(:id)
    else
      join.where(search_string(query)).group(:id)
    end
  end
end
