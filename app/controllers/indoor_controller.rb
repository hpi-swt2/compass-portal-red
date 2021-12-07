class IndoorController < ApplicationController
  def geojson
    buildings = Building.all

    render json: {
      type: "FeatureCollection",
      features: buildings.map(&:to_geojson).flatten
    }
  end
end
