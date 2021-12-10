class SearchController < ApplicationController
  def index
    return if params[:query].nil?

    @persons = Person.where("first_name like ? or last_name like ?", "%#{params[:query]}%", "%#{params[:query]}%")
    @rooms = Room.where("full_name like ?", "%#{params[:query]}%")
    @chairs = Chair.where("name like ?", "%#{params[:query]}%")

    @params = params[:query]
  end

  helper_method :index
end
