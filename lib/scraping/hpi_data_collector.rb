#   If you think this code is ugly try looking at hpi_paragraph_scraper.rb!

require "#{Rails.root}/lib/scraping/scraping_exception.rb"
require "#{Rails.root}/lib/scraping/hpi_table_scraper.rb"
require "#{Rails.root}/lib/scraping/hpi_paragraph_scraper.rb"

class HpiDataCollector
  @@title_words = %w[Prof. Dr. MSc. h.c.]
  @@professor_pages = %w[
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
  ]

  def initialize(base_url = 'https://hpi.de')
    @base_url = base_url
  end

  def get_names(name)
    person = {}

    name_list = name.split
    filtered_name_list = name_list - @@title_words

    person[:surname] = filtered_name_list.first
    person[:name] = filtered_name_list.last

    person
  end

  def get_title(name)
    person = {}

    name_list = name.split
    titles_list = name_list & @@title_words
    person[:title] = titles_list.join(" ")

    person
  end

  def get_scraping_info(url)
    person = {}

    document = get_html_document(url)

    # Get divs that contain the data
    content = document.css('#content')
    person_div = content.css('.csc-textpic')
    person_text_div = person_div.css('.csc-textpic-text')
    person_image_div = person_div.css('.csc-textpic-imagewrap')

    # Page contains table
    if person_text_div.css('table').any?
      scraper = HpiTableScraper.new(person_text_div)
      save_data(person, scraper, person_image_div)

    # Page contains multiple people
    elsif person_text_div.length > 1
      multiple_people_site(person, person_text_div)

    # Professor's page
    elsif @@professor_pages.include? url
      professor_site(person, person_text_div, person_image_div)

    # Page contains paragraphs
    else
      scraper = HpiParagraphScraper.new(person_text_div)
      save_data(person, scraper, person_image_div)
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

  def multiple_people_site(person, person_text_div)
    name_header = content.at("h2:contains('#{name}')")

    # Some pages have the peoples' names in h3 not in h2
    name_header ||= content.at("h3:contains('#{name}')")

    if name_header
      person_text_div = name_header.parent.parent.parent
      person_image_div = person_text_div.previous
    end

    scraper = HpiParagraphScraper.new(person_text_div)
    save_data(person, scraper, person_image_div)
  end

  def professor_site(person, person_text_div, person_image_div)
    name_strong = content.at("strong:contains('#{name}')")
    person_text_div = name_strong.parent.parent if name_strong

    scraper = HpiParagraphScraper.new(person_text_div)
    save_data(person, scraper, person_image_div)
  end

  def save_data(person, scraper, person_image_div)
    person[:website] = @base_url + url
    person_info = scraper.scrape
    person[:image] = scraper.download_image(person_image_div) if person_image_div
    person.merge(person_info)
  end
end
