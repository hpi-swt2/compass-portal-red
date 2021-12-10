require_relative 'hpi_data_collector'

# Root scraper class which handles scraping for all URLs
class Scraper
  def self.scrape
    url_records = PersonUrl.all

    data_collector = HpiDataCollector.new

    url_records.each do |record|
      scrape_record(data_collector, record)
    end
  end

  def self.scrape_record(data_collector, record)
    item = {}
    name_hash = data_collector.get_names(record[:name])
    title_hash = data_collector.get_title(record[:name])

    begin
      # Scrape and get info
      info_hash = data_collector.get_scraping_info(record[:name], record[:url])
    rescue ScrapingException
      # If scraping fails, skip and log a message
      Rails.logger.debug { "Scraping failed for #{record[:name]} @ #{record[:url]}:" }
      return
    end

    save_person(item.merge(name_hash).merge(title_hash).merge(info_hash))
  end

  def self.save_person(item)
    # If person exists update non-existent attributes, else create new person
    person = Person.find_by(last_name: item[:last_name], first_name: item[:first_name])
    if person
      update_person(person, item)
    else
      create_person(item)
    end
  end

  def self.update_person(person, item)
    # %w[email title image].each { |info_name| save_if_not_exists(person, item, info_name) }
    save_if_not_exists(person, item, "email")
    save_if_not_exists(person, item, "title")
    save_if_not_exists(person, item, "image")

    build_info_if_not_exists(person, item, "phone")
    build_info_if_not_exists(person, item, "website")
    add_room(person, item[:office]) unless person.room || !item[:office]
    person.save
  end

  def self.create_person(item)
    new_person = Person.new({
                              'title' => item[:title],
                              'first_name' => item[:first_name],
                              'last_name' => item[:last_name],
                              'email' => item[:email],
                              'image' => item[:image]
                            })
    build_info_if_not_exists(new_person, item, "phone")
    build_info_if_not_exists(new_person, item, "website")

    add_room(new_person, item[:office]) if item[:office]
    new_person.save
  end

  def self.save_if_not_exists(person, item, key)
    person[key] = item[key.to_sym] unless person[key]
  end

  def self.build_info_if_not_exists(person, item, key)
    return if person.informations.get_value(key)

    person.informations.build({
                                key: key,
                                value: item[key.to_sym]
                              })
  end

  # Save room on person
  def self.add_room(person, room)
    room = Room.find_or_create_by(number: room)
    person.room = room
  end
end
