require 'osm_helper'

include OsmHelper

parseOsm(File.open("app/assets/data/#{ARGV.first}"))
