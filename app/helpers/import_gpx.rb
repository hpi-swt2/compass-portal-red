require 'csv'
require 'point'
require 'room'
require 'building'
require 'polyline'
require 'nokogiri'

doc = Nokogiri::XML(File.open('app/assets/data/importBuilding1.gpx'))
rooms = doc.css("//trk")

rooms.each do |room_node|
  name_node = room_node.css("name").first
  name = name_node.content

  point_nodes = room_node.css("trkpt")
  points = []

  point_nodes.each do |point_node|
    lat = point_node["lat"]
    lon = point_node["lon"]

    print("Lat: " + lat + " Lon: " + lon + "\n")
    points.push([lat, lon])
  end

  # TODO: do sth with the room name and the points :D
end
