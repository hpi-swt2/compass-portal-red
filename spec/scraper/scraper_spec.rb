require 'rails_helper'
require './lib/scraping/scraper'

RSpec.describe Scraper, type: :feature do
  let(:base_url) { "#{Rails.root}/spec/scraper" }
  let(:scrape) { described_class.scrape(base_url) }

  before do
    PersonUrl.delete_all
    Person.delete_all

    FactoryBot.create :person_url
  end

  it "adds a maximum of one database entry after scraping" do
    previous_number_entries = Person.count
    scrape

    expect(Person.count).to be <= previous_number_entries + 1
  end

  it "scrapes an HPI webpage and stores the peoples' data in the database" do
    scrape

    expect(Person.first).to have_attributes(
      first_name: "Michael",
      last_name: "Perscheid",
      email: 'michael.perscheid(at)hpi.de'
    )
    expect(Person.first.image.attached?).to eq(true)
  end

  it "doesn't overwrite data if new data is found" do
    FactoryBot.create :person, email: 'michael.perscheid(at)hpi.de'
    FactoryBot.create :person_url, url: '/html_mocks/table_overwrite.html'

    scrape

    expect(Person.first).to have_attributes(
      first_name: "Michael",
      last_name: "Perscheid",
      email: 'michael.perscheid(at)hpi.de'
    )
  end

  # commented out for now
  # it "stores a room after scraping peoples' data and references it" do
  #   scrape

  #   scraped_person = Person.first

  #   expect(Room.where(id: scraped_person.room_id, number: 'Campus II (Villa), V-2.18')).to exist
  # end

  it "stores additional information after scraping" do
    scrape

    expect(Information.where(key: 'phone', value: '+49 (331) 5509-566')).to exist
    expect(Information.where(key: 'website', value: "#{base_url}/html_mocks/table.html")).to exist
  end

end
