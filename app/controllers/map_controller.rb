class MapController < ApplicationController
  def index
    # Map page, accessible without login
    @buildings = Building.all
    @points_of_interest = PointOfInterest.all.map { |poi| poi.to_geojson}
  end
end
