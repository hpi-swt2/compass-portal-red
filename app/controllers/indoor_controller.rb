class IndoorController < ApplicationController
  def demo
    @building = Building.new(rooms: [Room.new(
      outer_shape: Polyline.new(points: [
                                  Point.new(x: 30, y: 80),
                                  Point.new(x: 30, y: 30),
                                  Point.new(x: 80, y: 30),
                                  Point.new(x: 80, y: 80),
                                  Point.new(x: 30, y: 80)
                                ]),
      point_of_interests: [PointOfInterest.new(point: Point.new(x: 20, y: 50))],
      walls: [ Wall.new(polyline: Polyline.new(points: [
                                                 Point.new(x: 30, y: 30),
                                                 Point.new(x: 80, y: 80)
                                               ])) ]
    )])
  end

  def geojson
    buildings = Building.all

    render json: {
      type: "FeatureCollection",
      features: buildings.map(&:to_geojson).flatten
    }
  end
end
