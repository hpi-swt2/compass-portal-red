class SearchController < ApplicationController
  def index
    return if params[:query].nil?

    @results = Person.search(params[:query])
    @results += Room.search(params[:query])
    @results += Chair.search(params[:query])
    @params = params[:query]
  end

  helper_method :index
end
