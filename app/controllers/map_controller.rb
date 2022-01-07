class MapController < ApplicationController
  def index
    # Map page, accessible without login
    @buildings = Building.all
  end
end
