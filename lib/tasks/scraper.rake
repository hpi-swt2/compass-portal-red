require 'English'

# Run with `bundle exec rake compass_scraper:scrape`
namespace :compass_scraper do
  desc 'Update the scraped data by scraping the URLs stored in the DB'
  task scrape: :environment do
    puts "Scraped it!"
    # TODO: Add the call to the scraper here
    # If rails session / controller necessary: https://stackoverflow.com/questions/22936245/call-controller-from-rake-task/22936407
  end
end
