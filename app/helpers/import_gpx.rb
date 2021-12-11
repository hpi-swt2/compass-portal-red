require 'csv'
require 'indoor_helper'
require 'optparse'
require 'building'
require 'nokogiri'

include IndoorHelper

doc = Nokogiri::XML(File.open("app/assets/data/#{ARGV.first}"))
rooms = doc.css("//trk")
building = Building.create

rooms.each do |room_node|
  build_room_from(room_node, building)
end
