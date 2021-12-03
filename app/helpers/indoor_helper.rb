module IndoorHelper
    def geojson_for_polygon(points)
        if points[0] != points[-1]
            points.push(points[0])
        end
        {
            :type => "Feature",
            :geometry => {
                :type => "Polygon",
                :coordinates => points.map { |point| [point.x, point.y] }
            }
        }
    end
end
