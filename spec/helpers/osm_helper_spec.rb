require 'rails_helper'

RSpec.describe OsmHelper, type: :helper do
  let(:xml) do
    "<?xml version='1.0' encoding='UTF-8'?>"\
    "<osm version='0.6' generator='JOSM'>"\
    "<node id='-101755' lat='52.39417532053' lon='13.13278466329' />"\
    "<node id='-101762' lat='52.39398422012' lon='13.1324212709'>"\
    "<tag k='entrance' v='yes' />"\
    "<tag k='name' v='FrontEntrance' />"\
    "</node>"\
    "<way id='-101782'>"\
    "<nd ref='-101755' />"\
    "<nd ref='-101762' />"\
    "<nd ref='-101755' />"\
    "<tag k='indoor' v='room' />"\
    "<tag k='name' v='ExampleRoom' />"\
    "</way>"\
    "</osm>"
  end

  describe "OSMParser" do
    it "imports XML correctly" do
      parse_osm(xml)
      points = Point.all
      rooms = Room.all
      point_of_interests = PointOfInterest.all

      expect(points.count).to eq(2)
      expect(points.first.y).to eq(52.39417532053)
      expect(points.first.x).to eq(13.13278466329)
      
      expect(rooms.count).to eq(1)
      expect(rooms.first.full_name).to eq("ExampleRoom")

      expect(point_of_interests.count).to eq(1)
      expect(point_of_interests.first.name).to eq("Entrance")
    end
  end

  # Clean up db after tests
  after(:all) do
    PointOfInterest.destroy_all
    Point.destroy_all
    Room.destroy_all
    Floor.destroy_all
    Building.destroy_all
  end
end
