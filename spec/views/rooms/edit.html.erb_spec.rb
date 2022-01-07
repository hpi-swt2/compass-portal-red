require 'rails_helper'

RSpec.describe "rooms/edit", type: :view do
  let(:room) { FactoryBot.create(:room) }

  before { assign(:room, room) }

  it "renders the edit room form" do
    render

    assert_select "form[action=?][method=?]", room_path(room), "post"
  end
end
