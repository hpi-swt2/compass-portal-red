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
    room1 = Room.new(
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
    )
    render json: Building.new(rooms: [room1, room1]).to_geojson
  end
end
