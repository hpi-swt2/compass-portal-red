class SearchController < ApplicationController
  def index
    return if params[:query].nil?

    arr = Person.where("first_name like ? or last_name like ?", "%#{params[:query]}%", "%#{params[:query]}%")
    @query = []
    arr.each { |el| @query.push(el.full_name) }

    arr = Room.where("full_name like ?", "%#{params[:query]}%")
    arr.each { |el| @query.push("Room: #{el.full_name}") }

    arr = Chair.where("name like ?", "%#{params[:query]}%")
    arr.each { |el| @query.push("Chair: #{el.name}") }

    @params = params[:query]
  end

  helper_method :index
end
