require "#{Rails.root}/lib/scraping/scraping_exception.rb"

# Abstract class
class HpiWebScraper
    @@phone_words = ['Tel.:', 'Telefon:', 'telephone:', 'Telephone:', 'phone:', 'Phone:', 'Phone.:']
    @@office_words = ['office:', 'Office:', 'Raum:', 'Room:']
    @@email_words = ['Email:', 'E-mail:', 'E-Mail:']
    
    @@base_url = 'https://hpi.de'

    def initialize(html_document)
        @html = html_document
    end 

    def scrape(scrapeEmail=false)
        raise "Function has to be overriden."
    end

    # TODO
    def downloadImage(person_image_div)
        img_src = person_image_div.at_css('img').attr('src')
        img_src = @@base_url + img_src
        File.open('person.png', 'wb') do |f|
            f.write open(img_src).read 
        end 

        return 'person.png'

    end
end