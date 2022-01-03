require 'rails_helper'

RSpec.describe "rooms/new", type: :view do
  before do
    assign(:room, Room.new)
  end

  it "renders new room form" do
    render

    assert_select "form[action=?][method=?]", rooms_path, "post"
  end
end
