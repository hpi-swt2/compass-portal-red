require 'rails_helper'

# TODO: add some demo points in the factory-created wall
# TODO: test that newly created walls are valid and the factory-created walls are valid
RSpec.describe Wall, type: :model do
  it "has a constructor that can create instances" do
    instance = described_class.new
    expect(instance).to be_an_instance_of(described_class)
  end

  it "creates new walls with an empty list of points" do
    wall = described_class.new
    expect(wall.points).to eq([])
  end

  describe "db interaction" do
    let(:point1) { create :point }
    let(:point2) { create :point }
    let(:wall) { create :wall }

    # change the wall and save it to db
    before do
      point1.x = 0
      point2.x = 0.5
      wall.points = [point1, point2]
      wall.save!
    end
    
    it "has the wall saved in the db" do
      db_wall = described_class.find(wall.id)
      expect(db_wall).to be_an_instance_of(described_class)
      expect(wall.id).to eq(db_wall.id)
    end

    it "keeps an order of points" do
      expect(wall.points.size).to eq(2)
      expect(wall.points[0].x).to eq(point1.x)
      expect(wall.points[1].x).to eq(point2.x)
    end

    it "allows creating a cycle" do
      # push point 1 again and reload from db, to test if db supports adding a cycle containing the same point twice
      wall.points.push(point1)
      wall.save!
      db_wall = described_class.find(wall.id)


      expect(db_wall.points.size).to eq(3)
      expect(db_wall.points[0].id).to eq(point1.id)
      expect(db_wall.points[1].id).to eq(point2.id)
      expect(db_wall.points[2].id).to eq(point1.id)
    end
  end
end
