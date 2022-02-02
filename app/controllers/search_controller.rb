class SearchController < ApplicationController
  def index
    return if params[:query].nil?

    @exact_results = add_results_for(params[:query])

    words_in_query = params[:query].scan(/[A-Za-z0-9]+/)

    @more_results = words_in_query.flat_map { |word| add_results_for(word) }
    @more_results = sort(@more_results, params[:query]) - @exact_results

    @params = params[:query]
  end

  helper_method :index

  private

  def add_results_for(query)
    Person.search(query) +
      Room.search(query) +
      Chair.search(query) +
      Course.search(query)
  end

  def sort_by_priority(results, query)
    matching_tag_results = Room.search_by_tags(query)
    results_without_tags = results - matching_tag_results
    prioritized_results = results

    if results_without_tags.length < results.length
      # matching_tag_results are added to the front of the list because they have higher priority
      prioritized_results = matching_tag_results + results_without_tags
    end

    prioritized_results
  end

  def sort_by_frequency(array)
    array = array.tally
    array = array.sort_by(&:second).reverse!
    array.map(&:first)
  end

  def sort(results, query)
    results = sort_by_frequency(results)
    sort_by_priority(results, query)
  end
end
