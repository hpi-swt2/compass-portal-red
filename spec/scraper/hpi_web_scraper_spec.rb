require 'rails_helper'
require "#{Rails.root}/lib/hpi_web_scraper.rb"

RSpec.describe "HpiWebScraper", type: :feature do
  before :each do
    @webscraper = HpiWebScraper.new
  end

  it "extracts surname and name from a person's full name" do
    name = 'Prof. Holger Giese'
    name_hash = @webscraper.getNames(name)

    expect(name_hash[:surname] == 'Holger')
    expect(name_hash[:name] == 'Giese')
  end
  
end