require 'rails_helper'

RSpec.describe "rooms/index", type: :view do
  before(:each) do
    assign(:rooms, [
      Room.create!(),
      Room.create!()
    ])
  end

  it "renders a list of rooms" do
    render
  end
end
