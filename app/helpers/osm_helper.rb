require 'indoor_helper'
require 'optparse'
require 'building'
require 'nokogiri'

module OsmHelper
  include IndoorHelper

  def parse_osm(xml_string)
    doc = Nokogiri::XML(xml_string)
    potential_rooms = doc.css("//way")
    points = doc.css("//node")
    building = Building.create

    points.each do |point|
      build_point_from(point)
    end

    potential_rooms.each do |room|
      room.css("tag").each do |tag|
        build_room_from(room, building) if tag["k"] == "indoor" && tag["v"] == "room"
      end
    end
  end
end