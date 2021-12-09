require_relative 'hpi_data_collector'
require_relative 'problem_checker'

# Root scraper class which handles scraping for all URLs
class Scraper
  def self.scrape
    url_records = PersonUrl.all

    data_collector = HpiDataCollector.new
    problem_checker = ProblemChecker.new

    DataProblem.delete_all
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

      save_person(item.merge(name_hash).merge(title_hash).merge(info_hash), problem_checker)
    end
    problem_checker.check_for_empty_person_fields
  end

  def self.save_person(item, problem_checker)
    # If person exists update non-existent attributes, else create new person
    person = Person.find_by(name: item[:name], surname: item[:surname])
    if person
      save_existing_person(person, item, problem_checker)
    else
      Person.where(item).first_or_create
    end
  end

  def self.save_existing_person(person, item, problem_checker)
    person.email = item[:email] if problem_checker.check_for_conflict(person, item[:email], person.email)
    person.phone = item[:phone] if problem_checker.check_for_conflict(person, item[:phone], person.phone)
    person.office = item[:office] if problem_checker.check_for_conflict(person, item[:office], person.office)
    person.save
  end
end
