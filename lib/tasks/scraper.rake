require 'English'
require './lib/scraping/scraper.rb'

# Run with `bundle exec rake compass_scraper:scrape`
namespace :compass_scraper do
  desc 'Update the scraped data by scraping the URLs stored in the DB'
  task :scrape => :environment do
    puts "Scraping task started"
    Scraper::scrape
    puts "Scraping task finished"
  end
end
