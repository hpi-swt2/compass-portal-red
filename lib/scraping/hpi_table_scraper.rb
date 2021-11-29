require "#{Rails.root}/lib/scraping/hpi_web_scraper.rb"

class HpiTableScraper < HpiWebScraper
    def scrape(scrapeEmail=false)
        item = {}

        td_tags = @html.css('td')
        td_tags.each do |td|
            # Phone
            if ([td.text] & @@phone_words).any? then # Check if td_text is one of those words
                index = td_tags.find_index(td) # Save the index of the td in the td_tags array
                item[:phone] = td_tags[index+1].text # Next td in the array has to contain the phone number
            end
            # Office
            if ([td.text] & @@office_words).any? then 
                index = td_tags.find_index(td) 
                item[:office] = td_tags[index+1].text 
            end
        end

        return item
    end
    
end