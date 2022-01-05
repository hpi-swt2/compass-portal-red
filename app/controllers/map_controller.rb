class MapController < ApplicationController
  def index
    # Map page, accessible without login
    # FactoryBot.create :point_of_interest
    @points_of_interest = PointOfInterest.all.map { |poi| poi.to_geojson}
  end
end
