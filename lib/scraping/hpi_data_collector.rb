require_relative 'scraping_exception'
require_relative 'hpi_table_scraper'
require_relative 'hpi_paragraph_scraper'

class HpiDataCollector
  TITLE_WORDS = %w[Prof. Dr. MSc. h.c.].freeze
  PROF_PAGES = %w[
    /das-hpi/personen/professoren/prof-dr-holger-giese /das-hpi/personen/professoren/prof-dr-holger-karl
    /das-hpi/personen/professoren/prof-dr-christian-doerr /das-hpi/personen/professoren/prof-dr-erwin-boettinger
    /das-hpi/personen/professoren/prof-dr-christoph-lippert /das-hpi/personen/professoren/prof-dr-tobias-friedrich
    /das-hpi/personen/professoren/prof-dr-falk-uebernickel /das-hpi/personen/professoren/prof-dr-tilmann-rabl
    /das-hpi/personen/professoren/prof-dr-mathias-weske /das-hpi/personen/professoren/prof-dr-bernhard-renard
    /das-hpi/personen/professoren/prof-ulrich-weinberg /das-hpi/personen/professoren/prof-dr-gerard-de-melo
    /das-hpi/personen/professoren/prof-dr-hc-hasso-plattner /das-hpi/personen/professoren/prof-dr-christoph-meinel
    /das-hpi/personen/professoren/emeriti/zorn /das-hpi/personen/professoren/emeriti/prof-dr-siegfried-wendt
    /das-hpi/personen/professoren/prof-dr-andreas-polze /das-hpi/personen/professoren/prof-dr-felix-naumann
    /das-hpi/personen/professoren/prof-dr-juergen-doellner /das-hpi/personen/professoren/prof-dr-patrick-baudisch
    /das-hpi/personen/professoren/prof-dr-robert-hirschfeld /das-hpi/personen/professoren/prof-dr-katharina-hoelzle
    /das-hpi/personen/professoren/prof-dr-anja-lehmann
  ].freeze

  def initialize(base_url = 'https://hpi.de')
    @base_url = base_url
  end

  def get_names(name)
    person = {}

    name_list = name.split
    filtered_name_list = name_list - TITLE_WORDS

    person[:first_name] = filtered_name_list.first
    person[:last_name] = filtered_name_list.last

    person
  end

  def get_title(name)
    person = {}

    name_list = name.split
    titles_list = name_list & TITLE_WORDS
    person[:title] = titles_list.join(" ")

    person
  end

  def get_scraping_info(name, url)
    Rails.logger.debug { "Scraping #{name} @ #{url}" }
    person = {}

    person[:website] = @base_url + url

    document = get_html_document(url)

    # Get divs that contain the data
    content = document.css('#content')
    person_div = content.css('.csc-textpic')

    scrape_conditionally(person, name, url, content, person_div)
  end

  private

  def scrape_conditionally(person, name, url, content, person_div)
    person_text_div = person_div.css('.csc-textpic-text')
    person_image_div = person_div.css('.csc-textpic-imagewrap')

    # Page contains table
    if person_text_div.css('table').any?
      scraper = HpiTableScraper.new(person_text_div)
      collect(person, scraper, person_image_div)

      # Page contains multiple people
    elsif person_text_div.length > 1
      scrape_multiple_people_page(person, name, content, person_text_div)

      # Professor's page
    elsif PROF_PAGES.include? url
      scrape_professor_page(person, name, content, person_image_div, person_text_div)

      # Page contains paragraphs
    else
      scraper = HpiParagraphScraper.new(person_text_div)
      collect(person, scraper, person_image_div)
    end
  end

  def get_html_document(url)
    document = ''

    begin
      document = Nokogiri::HTML(URI.open(@base_url + url, allow_redirections: :all))
      raise ScrapingException, "Redirect" if document.title == 'Hasso-Plattner-Institut' # Redirect due to non-existance
    rescue OpenURI::HTTPError
      raise ScrapingException, "HTTPError"
    rescue SocketError
      raise ScrapingException, "SocketError"
    end

    document
  end

  def scrape_multiple_people_page(person, name, content, person_text_div)
    # Some pages have the peoples' names in h3 not in h2
    name_header = content.at("h2:contains('#{name}')") || content.at("h3:contains('#{name}')")

    if name_header
      person_text_div = name_header.parent.parent.parent
      person_image_div = person_text_div.previous
    end

    scraper = HpiParagraphScraper.new(person_text_div)
    collect(person, scraper, person_image_div)
  end

  def scrape_professor_page(person, name, content, person_image_div, person_text_div)
    # Some pages have professor name written bold, which lets us limit the person_text_div to it.
    person_text_div = content.at("strong:contains('#{name}')")&.parent&.parent || person_text_div
    scraper = HpiParagraphScraper.new(person_text_div)
    collect(person, scraper, person_image_div)
  end

  def collect(person, scraper, person_image_div)
    person_info = scraper.scrape

    person_info.each do | key, value |
      person_info[key] = value.strip if value
    end

    person[:image] = scraper.download_image(person_image_div) if person_image_div
    person.merge(person_info)
  end
end
