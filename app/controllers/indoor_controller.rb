class IndoorController < ApplicationController
  include IndoorHelper
  protect_from_forgery with: :null_session

  def geojson
    buildings = Building.all

    render json: {
      type: "FeatureCollection",
      features: buildings.map(&:to_geojson).flatten
    }
  end

  def import
    uploaded_io = params[:file]
    file = File.read(uploaded_io)
    build_building_from(file)
    redirect_to indoor_upload_path
  end

  def upload; end
end
