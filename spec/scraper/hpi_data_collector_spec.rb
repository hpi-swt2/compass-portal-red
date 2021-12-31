require 'rails_helper'
require "./lib/scraping/hpi_data_collector"

RSpec.describe HpiDataCollector, type: :feature do
  let(:base_url) { "#{Rails.root}/spec/scraper" }
  let(:data_collector) { described_class.new(base_url) }
  let(:name) { 'Prof. Dr. Holger Giese' }

  describe 'Text extraction' do

    it "extracts surname and name from a person's full name" do
      name_hash = data_collector.get_names(name)

      expect(name_hash).to eq(
        first_name: 'Holger',
        last_name: 'Giese'
      )
    end

    it "extracts the person's title from a person's full name" do
      title_hash = data_collector.get_title(name)

      expect(title_hash[:title]).to eq 'Prof. Dr.'
    end

  end

  describe "Web scraping" do

    it "scrapes an HPI web page where people data is stored in an HTML table" do
      person_url = ['Dr. Michael Perscheid', '/html_mocks/table.html']
      person_data = data_collector.get_scraping_info(person_url[0], person_url[1])

      expect(person_data).to eq(
        website: "#{base_url}#{person_url[1]}",
        email: 'michael.perscheid(at)hpi.de',
        phone: '+49 (331) 5509-566',
        office: 'Campus II (Villa), V-2.18',
        image: '/assets/images/people/Michael_Perscheid_Portrait_120x160.jpg'
      )
    end

    it "scrapes an HPI web page where people data is stored in an HTML paragraph" do
      person_url = ['Hannah Marienwald', '/html_mocks/paragraph.html']
      person_data = data_collector.get_scraping_info(person_url[0], person_url[1])

      expect(person_data).to eq(
        website: "#{base_url}#{person_url[1]}",
        email: 'Hannah.Marienwald(at)hpi.de',
        phone: '+49-(0) 331 5509 - 4865 ',
        office: 'F-1.06 ',
        image: '/assets/images/people/csm_HMarienwald_a0d164a1a3.jpg'
      )
    end

    it "scrapes an HPI web page where multiple people share the same page" do
      person_url = ['Lisa Rüppner', '/html_mocks/multiple_people.html']
      person_data = data_collector.get_scraping_info(person_url[0], person_url[1])

      expect(person_data).to eq(
        website: "#{base_url}#{person_url[1]}",
        email: 'lisa.rueppner(at)hpi.de',
        phone: '+49-(0)331 5509-120 ',
        office: 'B-1.12 ',
        image: '/assets/images/people/Lisa_R%C3%BCppner_180x240.jpg'
      )
    end

  end

end
