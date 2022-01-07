require 'nokogiri'

module IndoorHelper
  def build_point_from(point_node)
    lat = point_node["lat"]
    lon = point_node["lon"]
    osm_node_id = point_node["id"]

    point = Point.find_or_create_by(x: lon, y: lat, osm_node_id: osm_node_id)
    # check if it is POI
    point_node.css("tag").each do |tag|
      if tag["k"] == "entrance" && tag["v"] == "yes"
        PointOfInterest.find_or_create_by(point_id: point.id, point_type: "entrance")
      end
    end
  end

  def build_room_from(room_node, building)
    name = parse_room_name(room_node)
    points = parse_room_points(room_node)

    outer_shape = Polyline.create(points: points)
    room = Room.create(building: building, outer_shape: outer_shape, full_name: name)

    # add points to room
    points.each do |point|
      point.update(room_id: room.id)
    end
  end

  private
  def parse_room_name(room_node)
    name = nil
    room_node.css("tag").each do |tag|
      name = tag["v"] if tag["k"] == "name"
    end

    raise 'Parsing osm file failed (room name not found)' if name.nil?

    return name
  end

  def parse_room_points(room_node)
    points = []
    room_node.css("nd").each do |nd|
      points.push(Point.find_by(osm_node_id: nd["ref"]))
    end
    return points
  end
end
