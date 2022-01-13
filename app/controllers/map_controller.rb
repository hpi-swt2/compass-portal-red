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
    permitted = params.permit(:alternatives, :geometries, :include, :access_token, :steps)
    URI "https://api.mapbox.com/directions/v5/mapbox/#{profile}/#{coordinates}?#{permitted.to_query}"
  end
  
  def is_in_babelsberg point
    long, lat = point.gsub("%2E", ".").split(",")
    lat, long = lat.to_f, long.to_f

     (long > 13.1 && long < 13.3 && lat > 52.3 && lat < 52.5)
  end

  def directions 
    uri = self.url
    params[:coordinates] = params[:coordinates].gsub("p", "%2E")
    p1, p2 = params[:coordinates].split(";")
    if not is_in_babelsberg p1 or not is_in_babelsberg p2
       render json: "Errror! Not allowed to navigate outside of Babelsberg"
    end

    res = Net::HTTP.get_response(uri)
    render json: res.body
  end
end