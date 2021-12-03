require "#{Rails.root}/lib/scraping/hpi_web_scraper.rb"

class HpiTableScraper < HpiWebScraper
  def scrape
    item = {}

    td_tags = @html.css('td')
    td_tags.each do |td|
      # Phone
      if ([td.text] & @@phone_words).any? # Check if td_text is one of those words
        index = td_tags.find_index(td) # Save the index of the td in the td_tags array
        item[:phone] = td_tags[index + 1].text # Next td in the array has to contain the phone number
      end
      # Office
      if ([td.text] & @@office_words).any?
        index = td_tags.find_index(td)
        item[:office] = td_tags[index + 1].text
        item[:office] = td_tags[index + 2].text if item[:office] == '' # In case of separator
      end

      # Email
      if ([td.text] & @@email_words).any? && (@html.css('.mail').text != '')
        index = td_tags.find_index(td)
        item[:email] = td_tags[index + 1].text
      end
    end

    item
  end
end
