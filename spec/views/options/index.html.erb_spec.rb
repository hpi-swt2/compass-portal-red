require 'rails_helper'

RSpec.describe "options/index", type: :view do
  it "renders without an error" do
    render
    expect(rendered).to match("Sign in")
  end
end
