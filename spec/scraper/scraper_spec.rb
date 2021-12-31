require 'rails_helper'
require './lib/scraping/scraper'

RSpec.describe Scraper, type: :feature do

  let(:base_url) { "#{Rails.root}/spec/scraper" }

  before do
    PersonUrl.delete_all

    person_url = FactoryBot.build :person_url, name: 'Dr. Michael Perscheid', url: '/html_mocks/table.html'
    person_url.save
  end

  context "Person database is empty" do

    it "adds a database entry after scraping" do
        previous_number_entries = Person.count
        described_class.scrape(base_url)

        expect(Person.count).to eq(previous_number_entries + 1)
    end

    it "scrapes an HPI webpage and stores the peoples' data in the database" do

    end

    it "doesn't overwrite data if it already exists" do

    end

  end

end
