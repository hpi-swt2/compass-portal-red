class SearchController < ApplicationController
  # def index
  # Search page, accessible without login
  # end

  def index
    # basic array to test live search functionality
    # will be changed later when an actual DB exists
    arr = %w[Daniel Djamal Dan]
    return if params[:query].nil?

    @query = arr.select { |e| e.include?(params[:query]) }
    # print('================================')
    # print(@query)
    @query
    @params = params[:query]
  end

  helper_method :index
end
