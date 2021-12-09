require_relative 'hpi_data_collector'

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
        Rails.logger.debug { "Scraping failed for #{record[:name]} @ #{record[:url]}:" }
        next
      end

      save_person(item.merge(name_hash).merge(title_hash).merge(info_hash))
    end
  end

  def self.save_person(item)
    # If person exists update non-existent attributes, else create new person
    person = Person.find_by(last_name: item[:last_name], first_name: item[:first_name])
    if person
      person.email = item[:email] unless person.email
      person.title = item[:title] unless person.title
      person.image = item[:image] unless person.image
      person.informations.build({
        key: 'phone',
        value: item[:phone]
      }) unless person.informations.get_value('phone')
      person.informations.build({
        key: 'website',
        value: item[:website]
      }) unless person.informations.get_value('website')
      add_room(person, item[:office]) unless (person.room || !item[:office])
      person.save
    else
      newPerson = Person.new({
        'title' => item[:title],
        'first_name' => item[:first_name],
        'last_name' => item[:last_name],
        'email' => item[:email],
        'image' => item[:image]
      })
      newPerson.informations.build([
        {
          key: 'phone',
          value: item[:phone]
        }, {
          key: 'website',
          value: item[:website]
        }
      ])
      add_room(newPerson, item[:office]) unless !item[:office]
      newPerson.save
    end
  end

  # Save room on person
  def self.add_room(person, room)
    room = Room.find_or_create_by(number: room)
    person.room = room
  end
end
