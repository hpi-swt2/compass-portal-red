require "spec_helper"
require "nokogiri"

RSpec.describe IndoorHelper, type: :helper do
  let(:latitudes) { [52.39426575042, 52.39410268895, 52.39425695289] }
  let(:longitudes) { [13.13216440346, 13.13220027801, 13.13219726052] }
  let(:point_descriptions) do
    latitudes.zip(longitudes).map do |coord|
      "<trkpt lat=\"#{coord.first}\" lon=\"#{coord.second}\"></trkpt>"
    end
  end

  describe "point builder" do
    let(:point_nodes) do
      point_descriptions.map do |description|
        Nokogiri::XML("<root>#{description}\"></root>").root.children.first
      end
    end

    it "persists point" do
      build_point_from(point_nodes.first)
      expect(Point.where(x: longitudes.first, y: latitudes.first)).to exist
    end

    it "does not persist Point with same coordinates" do
      build_point_from(point_nodes.first)
      expect(Point.count).to eq(1)
      build_point_from(point_nodes.first)
      expect(Point.count).to eq(1)
    end

    it "persists two Points when coordinates are different" do
      build_point_from(point_nodes.first)
      build_point_from(point_nodes.second)
      expect(Point.count).to eq(2)
    end
  end

  describe "room builder" do
    let(:name) { 'HS Triangle' }
    let(:room_node) do
      Nokogiri::XML("<root><trk><name>#{name}</name><trkseg>#{point_descriptions.join}</trkseg></trk></root>").root.children.first
    end

    it "persists room" do
      building = create :building
      build_room_from(room_node, building)
      expect(Room.where(full_name: name)).to exist
    end
  end
end
