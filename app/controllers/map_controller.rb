class MapController < ApplicationController
  def index
    # Map page, accessible without login
    @buildings = Building.all
    @selected_room = Room.find(map_params[:room_id]) if map_params[:room_id].present?
  end

  def map_params
    params.permit(:room_id)
  end
end
