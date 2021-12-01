require "#{Rails.root}/lib/scraping/scraping_exception.rb"
require "#{Rails.root}/lib/scraping/hpi_table_scraper.rb"
require "#{Rails.root}/lib/scraping/hpi_paragraph_scraper.rb"

class HpiDataCollector
  @@title_words = %w[Prof. Dr.]

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

  def get_scraping_info(name, url)
    person = {}

    document = get_html_document(url)

    # Get divs that contain the data
    content = document.css('#content')
    person_div = content.css('.csc-textpic')
    person_text_div = person_div.css('.csc-textpic-text')
    person_image_div = person_div.css('.csc-textpic-imagewrap')

    scraper = ""

    # Page contains table
    if person_text_div.css('table').any?
      scraper = HpiTableScraper.new(person_text_div)
    # Page contains multiple people
    elsif person_text_div.length > 1
      name_header = content.at("h2:contains('#{name}')")

      # Some pages have the peoples' names in h3 not in h2
      name_header ||= content.at("h3:contains('#{name}')")

      if name_header
        person_text_div = name_header.parent.parent.parent
        person_image_div = person_text_div.previous
      end

      scraper = HpiParagraphScraper.new(person_text_div)
    # Page contains paragraphs
    else
      scraper = HpiParagraphScraper.new(person_text_div)
    end

    person[:website] = @base_url + url
    person_info = scraper.scrape
    person[:image] = scraper.download_image(person_image_div) if person_image_div
    person.merge(person_info)
  end

  def get_html_document(url)
    document = ''

    begin
      document = Nokogiri::HTML(URI.open(@base_url + url, allow_redirections: :all))
      raise ScrapingException, "Redirect" if document.title == 'Hasso-Plattner-Institut' # Redirect due to non-existance
    rescue OpenURI::HTTPError => e
      raise ScrapingException, "HTTPError"
    rescue SocketError => e
      raise ScrapingException, "SocketError"
    end

    document
  end

end