class IndoorController < ApplicationController
    def demo
        @room = Room.new(
            outerShape: [
                Point.new(x: 30, y: 80),
                Point.new(x: 30, y: 30),
                Point.new(x: 80, y: 30),
                Point.new(x: 80, y: 80)
            ],
            point_of_interests: [PointOfInterest.new(point: Point.new(x: 20, y: 50))],
            walls: [ Wall.new(points: [
                Point.new(x: 30, y: 30),
                Point.new(x: 80, y: 80)
            ]) ]
        )
    end
    include IndoorHelper
    def geojson
        render json: Room.new(
            outerShape: [
                Point.new(x: 30, y: 80),
                Point.new(x: 30, y: 30),
                Point.new(x: 80, y: 30),
                Point.new(x: 80, y: 80)
            ],
            point_of_interests: [PointOfInterest.new(point: Point.new(x: 20, y: 50))],
            walls: [ Wall.new(points: [
                Point.new(x: 30, y: 30),
                Point.new(x: 80, y: 80)
            ]) ]
        ).to_geojson
    end
end
