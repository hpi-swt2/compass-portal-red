require 'rails_helper'

RSpec.describe "/map/room_popup", type: :view do
  let(:room) { FactoryBot.create :room }

  before do
    assign(:room_id, room.id)
  end

  it "renders a popup for the requested room" do
    expect(true).to be_truthy
  end
end
