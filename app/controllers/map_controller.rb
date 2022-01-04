require 'uri'
require 'net/http'


class MapController < ApplicationController
  def index
    # Map page, accessible without login
  end

  def directions 
    profile = params[:profile]
    coordinates = params[:coordinates]
    params[:access_token] = ENV['MAPBOX_ACCESS_TOKEN']
    permitted = params.permit(:alternatives, :geometries, :include, :access_token)
    uri = URI "https://api.mapbox.com/directions/v5/mapbox/#{profile}/#{coordinates}?#{permitted.to_query}"
    # render json: '"' + uri.to_s + '"'
    res = Net::HTTP.get_response(uri)
    render json: res.body
  end
end
