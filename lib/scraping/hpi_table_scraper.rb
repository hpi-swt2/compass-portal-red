require "#{Rails.root}/lib/scraping/hpi_web_scraper.rb"

class HpiTableScraper < HpiWebScraper
  def scrape
    item = {}

    item[:email] = @html.css('.mail').text

    td_tags = @html.css('td')
    td_tags.each do |td|
      item[:phone] = scrape_phone(td, td_tags)
      item[:office] = scrape_office(td, td_tags)
    end

    item
  end

  def scrape_phone(element, td_tags)
    return unless ([element.text] & @@phone_words).any?

    # Check if td_text is one of those words
    index = td_tags.find_index(element) # Save the index of the td in the td_tags array
    td_tags[index + 1].text # Next td in the array has to contain the phone number
  end

  def scrape_office(element, td_tags)
    return unless ([element.text] & @@office_words).any?

    index = td_tags.find_index(element)
    td_tags[index + 1].text
  end

end
