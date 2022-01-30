require 'uri'
require 'net/http'

class MapController < SearchController
  layout 'fullpage'

  def index
    super
    # Map page, accessible without login
    @buildings = Building.all
    @points_of_interest = PointOfInterest.all.map(&:to_geojson)
    @selected_room = Room.find(map_params[:room_id]) if map_params[:room_id].present?
  end

  def map_params
    params.permit(:room_id)
  end

  def navigation
    @buildings = Building.all
    @points_of_interest = PointOfInterest.all.map(&:to_geojson)

    p1 = params[:coordinate].gsub("p", ".")
    long1, lat1 = p1.split(",")
    
    @coordinates = [{lat: lat1.to_f, lng: long1.to_f}]
    render action: "index"
  end 

  def url
    profile = params[:profile]
    coordinates = params[:coordinates].gsub("p", "%2E")
    params[:access_token] = ENV['MAPBOX_ACCESS_TOKEN']
    ActionController::Parameters.action_on_unpermitted_parameters = false
    permitted = params.permit(:alternatives, :geometries, :include, :access_token, :steps)
    ActionController::Parameters.action_on_unpermitted_parameters = :raise
    URI "https://api.mapbox.com/directions/v5/mapbox/#{profile}/#{coordinates}?#{permitted.to_query}"
  end

  def in_babelsberg(point)
    long, lat = point.gsub("%2E", ".").split(",")
    lat = lat.to_f
    long = long.to_f

    (long > 13.1 && long < 13.3 && lat > 52.3 && lat < 52.5)
  end

  def directions
    uri = url
    params[:coordinates] = params[:coordinates].gsub("p", "%2E")
    p1, p2 = params[:coordinates].split(";")
    if !in_babelsberg(p1) && !in_babelsberg(p2)
      render json: "Error! Not allowed to navigate outside of Babelsberg" and return
    end

    res = Net::HTTP.get_response(uri)
    render json: res.body
  end
end
