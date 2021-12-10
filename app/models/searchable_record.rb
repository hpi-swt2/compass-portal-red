class SearchableRecord < ApplicationRecord
    self.abstract_class = true
    
    def searchable_attributes
      return []
    end
      
    def self.search(query)
      return self.where("first_name like ?", "%#{query}%")

    end
end