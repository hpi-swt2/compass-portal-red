<<<<<<< HEAD
class MapController < ApplicationController
  def index
    # Map page, accessible without login
    @buildings = Building.all
  end
end
=======
class MapController < ApplicationController
  def index
    # Map page, accessible without login
    @buildings = Building.all
    @points_of_interest = PointOfInterest.all.map(&:to_geojson)
  end
end
>>>>>>> dev
