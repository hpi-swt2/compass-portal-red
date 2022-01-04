require 'optparse'
require 'nokogiri'

module IndoorHelper
  def build_building_from(gpx)
    doc = Nokogiri::XML(gpx)
    rooms = doc.css("//trk")
    building = Building.create

    rooms.each { |room_node| build_room_from(room_node, building) }
  end

  def build_point_from(point_node)
    lat = point_node["lat"]
    lon = point_node["lon"]

    Point.find_or_create_by(x: lon, y: lat)
  end

  def build_room_from(room_node, building)
    name_node = room_node.css("name").first
    name = name_node.content

    point_nodes = room_node.css("trkpt")
    points = point_nodes.map { |point_node| build_point_from(point_node) }

    points.push(points.first)
    outer_shape = Polyline.create(points: points)
    Room.create(building: building, outer_shape: outer_shape, full_name: name)
  end
end
