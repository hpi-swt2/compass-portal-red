require 'English'
require "#{Rails.root}/lib/scraping/hpi_data_collector.rb"

# Run with `bundle exec rake compass_scraper:scrape`
namespace :compass_scraper do
  desc 'Update the scraped data by scraping the URLs stored in the DB'
  task :scrape => :environment do
    puts "Opening session for rails server"
    session = ActionDispatch::Integration::Session.new(Rails.application)
    # puts session.post "/people/scrape", options: {basic_auth: {username: 'red', password: 'secret'}}
    scrape
    # TODO: Add the call to the scraper here
    # If rails session / controller necessary: https://stackoverflow.com/questions/22936245/call-controller-from-rake-task/22936407
  end

  def scrape
    url_records = PersonUrl.all

    data_collector = HpiDataCollector.new

    url_records.each do |record|
      item = {}
      name_hash = data_collector.get_names(record[:name])
      title_hash = data_collector.get_title(record[:name])

      begin
        # Scrape and get info
        info_hash = data_collector.get_scraping_info(record[:name], record[:url])
      rescue ScrapingException
        next
      end

      save_person(item.merge(name_hash).merge(title_hash).merge(info_hash))
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def person_params
    params.require(:person).permit(:name, :surname, :title, :email, :phone, :office, :website, :image, :chair,
                                   :office_hours, :telegram_handle, :knowledge)
  end

  def save_person(item)
    # If person exists update non-existent attributes, else create new person
    person = Person.find_by(name: item[:name], surname: item[:surname])
    if person
      person.email = item[:email] unless person.email
      person.phone = item[:phone] unless person.phone
      person.office = item[:office] unless person.office
      person.save
    else
      Person.where(item).first_or_create
    end
  end
end
