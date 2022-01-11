class SearchController < ApplicationController
  def index
    return if params[:query].nil?

    @exact_results = add_results_for(params[:query])

    words_in_query = params[:query].scan(/[A-Za-z0-9]+/)

    @more_results = words_in_query.flat_map { |word| add_results_for(word) }
    @more_results = sort_by_frequency(@more_results) - @exact_results

    @params = params[:query]
  end

  helper_method :index

  private

  def add_results_for(query)
    Person.search(query) +
      Room.search(query) +
      Chair.search(query)
  end

  def sort_by_frequency(array)
    array = array.tally
    array = array.sort_by(&:second).reverse!
    array.map(&:first)
  end
end
