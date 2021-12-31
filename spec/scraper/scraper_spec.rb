require 'rails_helper'
require './lib/scraping/scraper'

RSpec.describe Scraper, type: :feature do

  let(:base_url) { "#{Rails.root}/spec/scraper" }

  before do
    PersonUrl.delete_all
    person_url = FactoryBot.build :person_url
    person_url.save
  end

  context "Person database is empty" do

    it "adds a maximum of one database entry after scraping" do
        previous_number_entries = Person.count
        described_class.scrape(base_url)

        expect(Person.count).to be <= previous_number_entries + 1
    end

    it "scrapes an HPI webpage and stores the peoples' data in the database" do
        described_class.scrape(base_url)
        
        expect(Person.all.first).to have_attributes(
            :first_name => "Michael",
            :last_name => "Perscheid",
            :email => 'michael.perscheid(at)hpi.de',
            :image => '/assets/images/people/Michael_Perscheid_Portrait_120x160.jpg'
        )
    end

    it "doesn't overwrite data if new data is found" do
        FactoryBot.create :person_url, url: '/html_mocks/table_overwrite.html'
        described_class.scrape(base_url)
        
        expect(Person.all.first).to have_attributes(
            :first_name => "Michael",
            :last_name => "Perscheid",
            :email => 'michael.perscheid(at)hpi.de',
            :image => '/assets/images/people/Michael_Perscheid_Portrait_120x160.jpg'
        )
    end

  end

end
