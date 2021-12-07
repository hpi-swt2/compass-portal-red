# Root scraper class which handles scraping for all URLs
class Scraper
  def self.scrape
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
        # If scraping fails, skip and log a message
        puts "Scraping failed for #{record[:name]} @ #{record[:url]}:"
        next
      end

      save_person(item.merge(name_hash).merge(title_hash).merge(info_hash))
    end
  end

  private

  def self.save_person(item)
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