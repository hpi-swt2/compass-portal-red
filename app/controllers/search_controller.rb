class SearchController < ApplicationController

  def index
    # basic array to test live search functionality
    # will be changed later when an actual DB exists
    arr = []
    return if params[:query].nil?
    
    arr = Person.where("first_name like ? or last_name like ?", "%#{params[:query]}%", "%#{params[:query]}%") #where("first_name like ? or last_name like ?", params[:query].to_str , params[:query].to_str).select("first_name").to_sql
    
    @query = []
    arr.each { |el| @query.push(el.full_name) }
    @params = params[:query]
  end

  helper_method :index
end
