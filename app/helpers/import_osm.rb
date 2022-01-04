require 'csv'
require 'indoor_helper'
require 'optparse'
require 'building'
require 'nokogiri'

include IndoorHelper

doc = Nokogiri::XML(File.open("app/assets/data/#{ARGV.first}"))
potential_rooms = doc.css("//way")
points = doc.css("//node")
building = Building.create

points.each do |point|
  build_point_from(point)
end

potential_rooms.each do |room|
  room.css("tag").each do |tag|
    if tag["k"] == "indoor" and tag["v"] == "room" then
      build_room_from(room, building)
    end
  end
end
