require "rails_helper"

RSpec.describe IndoorHelper, type: :helper do
  let(:ids) { [1, 2, 3] }
  let(:latitudes) { [52.39426575042, 52.39410268895, 52.39425695289] }
  let(:longitudes) { [13.13216440346, 13.13220027801, 13.13219726052] }
  let(:point_descriptions) do
    ids.zip(latitudes, longitudes).map do |info|
      "<node id=\"#{info.first}\" lat=\"#{info.second}\" lon=\"#{info.third}\" />"
    end
  end
  let(:point_references) do
    ids.map do |id|
      "<nd ref=\"#{id}\" />"
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
      former_point_count = Point.count
      build_point_from(point_nodes.first)
      expect(Point.count).to eq(former_point_count + 1)
      build_point_from(point_nodes.first)
      expect(Point.count).to eq(former_point_count + 1)
    end

    it "persists two Points when coordinates are different" do
      former_point_count = Point.count
      build_point_from(point_nodes.first)
      build_point_from(point_nodes.second)
      expect(Point.count).to eq(former_point_count + 2)
    end
  end

  describe "room builder" do
    let(:name) { 'HS Triangle' }
    let(:room_node) do
      xml = Nokogiri::XML(
        "<root>"\
        "<way>"\
        "#{point_references.join}"\
        "<tag k=\"indoor\" v=\"room\" />"\
        "<tag k=\"name\" v=\"#{name}\" />"\
        "</way>"\
        "#{point_descriptions.join}"\
        "</root>"
      )
      xml.root.children.first
    end

    it "persists room" do
      # save points in database so room can reference them
      point_descriptions.map do |description|
        build_point_from(Nokogiri::XML("<root>#{description}\"></root>").root.children.first)
      end

      building = create :building
      build_room_from(room_node, building)
      expect(Room.where(full_name: name)).to exist
    end
  end
end
