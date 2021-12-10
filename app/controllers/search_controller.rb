class SearchController < ApplicationController
  def index
    return if params[:query].nil?

    @persons = Person.search(params[:query])
    #@rooms = Room.search(params[:query])
    @rooms = []
    #@chairs = Chair.search(params[:query])
    @chairs = []
    @params = params[:query]
  end

  helper_method :index
end
