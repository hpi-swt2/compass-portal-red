class SearchController < ApplicationController
  #def index
    # Search page, accessible without login
  #end

  def index
    # basic array to test live search functionality
    # will be changed later when an actual DB exists
    arr = ['Daniel', 'Djamal', 'Dan']
    if (params[:query] == nil) 
      return 
    end
    @query = arr.select{|e| e.include?(params[:query])}
    #print('================================')
    #print(@query)
    return @query
  end

  helper_method :index
end
