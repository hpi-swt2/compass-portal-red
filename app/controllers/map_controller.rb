class MapController < ApplicationController
  layout 'fullpage'

  def index
    # Map page, accessible without login
    @buildings = Building.all
    @points_of_interest = PointOfInterest.all.map(&:to_geojson)
    @selected_room = Room.find(map_params[:room_id]) if map_params[:room_id].present?
  end

  def map_params
    params.permit(:room_id)
  end
end
