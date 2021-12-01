require 'rails_helper'
require "#{Rails.root}/lib/scraping/hpi_data_collector.rb"

RSpec.describe "HpiDataCollector", type: :feature do
  before do
    @base_url = "#{Rails.root}/spec/scraper"
    @dataCollector = HpiDataCollector.new(@base_url)
  end

  # Unit tests

  it "extracts surname and name from a person's full name" do
    name = 'Prof. Dr. Holger Giese'
    name_hash = @dataCollector.get_names(name)

    expect(name_hash[:surname]).to eq 'Holger'
    expect(name_hash[:name]).to eq 'Giese'
  end

  it "extracts the person's title from a person's full name" do
    name = 'Prof. Dr. Holger Giese'
    title_hash = @dataCollector.get_title(name)

    expect(title_hash[:title]).to eq 'Prof. Dr.'
  end

  # Integration tests

  it "scrapes an HPI web page where people data is stored in an HTML table" do
    person_url = ['Dr. Michael Perscheid', '/html_mocks/table.html']
    person_data = @dataCollector.get_scraping_info(person_url[0], person_url[1])

    expect(person_data[:website]).to eq "#{@base_url}#{person_url[1]}"
    expect(person_data[:email]).to eq 'michael.perscheid(at)hpi.de'
    expect(person_data[:phone]).to eq '+49 (331) 5509-566'
    expect(person_data[:office]).to eq 'Campus II (Villa), V-2.18'

    expect(person_data[:image]).to eq '/app/assets/images/people/Michael_Perscheid_Portrait_120x160.jpg'
  end

  it "scrapes an HPI web page where people data is stored in an HTML paragraph" do
    person_url = ['Hannah Marienwald', '/html_mocks/paragraph.html']
    person_data = @dataCollector.get_scraping_info(person_url[0], person_url[1])

    expect(person_data[:website]).to eq "#{@base_url}#{person_url[1]}"
    expect(person_data[:email]).to eq 'Hannah.Marienwald(at)hpi.de'
    expect(person_data[:phone]).to eq '+49-(0) 331 5509 - 4865 '
    expect(person_data[:office]).to eq 'F-1.06'

    expect(person_data[:image]).to eq '/app/assets/images/people/csm_HMarienwald_a0d164a1a3.jpg'
  end

  it "scrapes an HPI web page where multiple people share the same page" do
    person_url = ['Lisa Rüppner', '/html_mocks/multiple_people.html']
    person_data = @dataCollector.get_scraping_info(person_url[0], person_url[1])

    expect(person_data[:website]).to eq "#{@base_url}#{person_url[1]}"
    expect(person_data[:email]).to eq 'lisa.rueppner(at)hpi.de'
    expect(person_data[:phone]).to eq '+49-(0)331 5509-120 '
    expect(person_data[:office]).to eq 'B-1.12'

    expect(person_data[:image]).to eq '/app/assets/images/people/Lisa_R%C3%BCppner_180x240.jpg'

  end

end
