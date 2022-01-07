class SearchController < ApplicationController
  def index
    return if params[:query].nil?

    queries = params[:query].scan(/[A-Za-z0-9]+/)
    results = []

    @exact_results = Person.search(params[:query])
    @exact_results += Room.search(params[:query])
    @exact_results += Chair.search(params[:query])

    queries.each do |query|
      results += Person.search(query)
      results += Room.search(query)
      results += Chair.search(query)
    end

    results = results.tally.sort_by { |record| record.second }.reverse!
    @more_results = results.map {|record| record.first}.delete_if { |record| @exact_results.include? record }
    @params = params[:query]
  end

  helper_method :index
end
