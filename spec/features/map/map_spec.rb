require 'rails_helper'

describe "map page", type: :feature do
  it "should exist a map page and render withour error" do
    visit map_path
  end
end