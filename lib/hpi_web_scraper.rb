require "#{Rails.root}/lib/scraping_exception.rb"

# Abstract class
class HpiWebScraper
    @@phone_words = ['Tel.:', 'Telefon:', 'telephone:', 'Telephone:', 'phone:', 'Phone:', 'Phone.:']
    @@office_words = ['office:', 'Office:', 'Raum:', 'Room:']
    @@email_words = ['Email:', 'E-mail:', 'E-Mail:']
    
    @@base_url = 'https://hpi.de'

    def initialize(html_document)
        @html = html_document
    end 

    def scrape
        raise "Function has to be overriden."
    end
end