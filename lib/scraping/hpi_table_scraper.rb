require_relative "hpi_web_scraper"

class HpiTableScraper < HpiWebScraper
  def scrape
    item = {}

    td_tags = @html.css('td')

    item[:phone] = scrape_phone(td_tags, item)
    item[:office] = scrape_office(td_tags, item)

    # Check the whole document for a `.mail` tag
    item[:email] = @html.css('.mail')&.text
    # In case '.mail' class does not exist on the whole web page
    if item[:email] == ''
      item[:email] = scrape_mail(td_tags, item) 
    end

    item
  end

  def scrape_phone(td_tags, item)
    td_tags.each do |td|
      if ([td.text] & PHONE_WORDS).any? # Check if td_text is one of those words
        index = td_tags.find_index(td) # Save the index of the td in the td_tags array
        item[:phone] = td_tags[index + 1].text # Next td in the array has to contain the phone number
      end
    end

    item[:phone]
  end

  def scrape_office(td_tags, item)
    td_tags.each do |td|
      next unless ([td.text] & OFFICE_WORDS).any?

      index = td_tags.find_index(td)
      item[:office] = td_tags[index + 1].text
      item[:office] = td_tags[index + 2].text if item[:office] == '' # In case of separator
    end

    item[:office]
  end

  def scrape_mail(td_tags, item)
    td_tags.each do |td|
      if ([td.text] & EMAIL_WORDS).any?
        index = td_tags.find_index(td)
        item[:email] = td_tags[index + 1].text
      end
    end

    item[:email].gsub(/[[:space:]]/, '')
  end
end
