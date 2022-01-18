require 'osm_helper'

include OsmHelper

parse_osm(File.open("app/assets/data/#{ARGV.first}"))
