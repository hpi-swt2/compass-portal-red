require 'rails_helper'
require "#{Rails.root}/lib/scraping/hpi_data_collector.rb"

RSpec.describe "HpiDataCollector", type: :feature do
  before :each do
    @dataCollector = HpiDataCollector.new
  end

  it "extracts surname and name from a person's full name" do
    name = 'Prof. Dr. Holger Giese'
    name_hash = @dataCollector.getNames(name)

    expect(name_hash[:surname] == 'Holger')
    expect(name_hash[:name] == 'Giese')
  end

  it "extracts the person's title from a person's full name" do
    name = 'Prof. Dr. Holger Giese'
    title_hash = @dataCollector.getTitle(name)

    expect(title_hash[:title] == 'Prof. Dr.')
  end
  
end