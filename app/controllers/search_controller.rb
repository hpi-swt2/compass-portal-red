class SearchController < ApplicationController
  def index
    return if params[:query].nil?

    unless params[:query] == ""
      @exact_results = add_results_for(params[:query])
      @more_results = more_results(params, @exact_results)
    end

    @query = params[:query]
    handle_ajax
  end

  helper_method :index

  private

  def more_results(params, exact_results)
    words_in_query = params[:query].scan(/[A-Za-z0-9]+/)

    more_results = words_in_query.flat_map { |word| add_results_for(word) }
    related_results = (exact_results + more_results).uniq.map(&:related_searchable_records).flatten
    sort(more_results + related_results, related_results, params[:query]) - exact_results
  end

  def add_results_for(query)
    Person.search(query) +
      Room.search(query) +
      Chair.search(query) +
      Course.search(query)
  end

  def sort_by_priority(results, query)
    words_in_query = query.scan(/[A-Za-z0-9]+/)
    matching_tag_results = words_in_query.flat_map { |word| Room.search_by_tags(word) }.uniq
    results_without_tags = results - matching_tag_results
    prioritized_results = results

    if results_without_tags.length < results.length
      # matching_tag_results are added to the front of the list because they have higher priority
      prioritized_results = matching_tag_results + results_without_tags
    end

    prioritized_results
  end

  def compare
    lambda { |tuple1, tuple2|
      if tuple1.second == tuple2.second
        tuple1.third <=> tuple2.third
      else
        tuple2.second <=> tuple1.second
      end
    }
  end

  def sort_by_frequency(primary_results, secondary_results)
    # If the primary result frequency is the same the results are sorted by
    # how often they appear in the related matches (secondary result frequency) in ascending order
    primary_results_frequencies = primary_results.tally
    secondary_results_frequencies = secondary_results.tally

    results = []
    primary_results_frequencies.each do |key, value|
      if secondary_results_frequencies.key?(key)
        results.push([key, value, secondary_results_frequencies[key]])
      else
        results.push([key, value, 0])
      end
    end

    results.sort(&compare).map(&:first)
  end

  def sort(more_results, related_results, query)
    results = sort_by_frequency(more_results, related_results)
    sort_by_priority(results, query)
  end

  def handle_ajax
    if params[:ajax].nil?
      @full_render = true
    elsif params[:ajax] == "search"
      render json: { html: render_to_string(partial: "partials/search_results"), search: @query }
    elsif params[:ajax] == "map"
      render json: { html: render_to_string(partial: "partials/map_js"), search: @query }
    end
  end
end
