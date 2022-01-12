require 'rails_helper'

RSpec.describe "rooms/index", type: :view do
  let(:rooms) { FactoryBot.create_list(:room, 2) }

  before do
    assign(:rooms, rooms);
  end

  it "renders a list of rooms" do
    render
  end
end
