class MapController < ApplicationController
  def index
    # Map page, accessible without login
    # FactoryBot.create :point_of_interest
    @PoI = PointOfInterest.all.map { |poi| poi.to_geojson}
  end
end
