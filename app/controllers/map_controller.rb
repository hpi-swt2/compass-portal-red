require 'uri'
require 'net/http'


class MapController < ApplicationController
  def index
    # Map page, accessible without login
  end

  def url
    profile = params[:profile]
    coordinates = params[:coordinates].gsub("p", "%2E")
    params[:access_token] = ENV['MAPBOX_ACCESS_TOKEN']
    ActionController::Parameters.action_on_unpermitted_parameters = false
    permitted = params.permit(:alternatives, :geometries, :include, :access_token, :steps)
    ActionController::Parameters.action_on_unpermitted_parameters = :raise
    uri = URI "https://api.mapbox.com/directions/v5/mapbox/#{profile}/#{coordinates}?#{permitted.to_query}"
  end
  
  def is_in_babelsberg point
    long, lat = point.gsub("%2E", ".").split(",")
    lat, long = lat.to_f, long.to_f

    mybool = (long > 13.1 and long < 13.3 and lat > 52.3 and lat < 52.5)
    return mybool
  end

  def directions 
    uri = self.url
    params[:coordinates] = params[:coordinates].gsub("p", "%2E")
    p1, p2 = params[:coordinates].split(";")
    if not is_in_babelsberg p1 and not is_in_babelsberg p2
       return "Error! Not allowed to navigate outside of Babelsberg"
    end

    res = Net::HTTP.get_response(uri)
    render json: res.body
  end
end
