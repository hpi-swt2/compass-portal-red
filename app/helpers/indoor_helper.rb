require 'nokogiri'

module IndoorHelper
  def build_point_from(point_node)
    lat = point_node["lat"]
    lon = point_node["lon"]
    osm_node_id = point_node["id"]
    
    point = Point.find_or_create_by(x: lon, y: lat, osm_node_id: osm_node_id)
    # check if it is POI
    point_node.css("tag").each do |tag|
      if tag["k"] == "entrance" and tag["v"] == "yes" then
        PointOfInterest.find_or_create_by(point_id: point.id, point_type: "entrance")
      end
    end

  end

  def build_room_from(room_node, building)
    # find room name
    name = nil
    room_node.css("tag").each do |tag|
      if tag["k"] == "name" then
        name = tag["v"]
      end
    end
    if name.nil? then
      raise 'Parsing osm file failed (room name not found)'
    end
    
    points = Array.new
    room_node.css("nd").each do |nd|
      points.push(Point.find_by(osm_node_id: nd["ref"]))
    end

    outer_shape = Polyline.create(points: points)
    room = Room.create(building: building, outer_shape: outer_shape, full_name: name)

    points.each do |point|
      point.update(room_id: room.id)
    end
  end
end
