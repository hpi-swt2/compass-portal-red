require "#{Rails.root}/lib/scraping/scraping_exception.rb"
require "#{Rails.root}/lib/scraping/hpi_table_scraper.rb"
require "#{Rails.root}/lib/scraping/hpi_paragraph_scraper.rb"

class HpiDataCollector
    @@base_url = 'https://hpi.de'

    def getNames(name)
        person = {}

        name_list = name.split()
        filtered_name_list = name_list - ['Prof.', 'Dr.']

        person[:surname] = filtered_name_list.first
        person[:name] = filtered_name_list.last

        return person
    end

    def getScrapingInfo(url)
        person = {}

        document = getHTMLDocument(url)

        # Get divs that contain the data
        person_div = document.css('.csc-textpic')
        person_text_div = person_div.css('.csc-textpic-text')
        person_image_div = person_div.css('.csc-textpic-imagewrap')

        person[:email] = person_text_div.css('.mail').text

        person_info = {}
        scraper = ""

        # Page contains table
        if person_text_div.css('table').any? then
            scraper = HpiTableScraper.new(person_text_div)
        # Page contains paragraphs instead
        else
            scraper = HpiParagraphScraper.new(person_text_div)
        end
        # Page contains multiple people
        # TODO

        person_info = scraper.scrape(scrapeEmail=(person[:email] == ''))
        # person[:image] = scraper.downloadImage(person_image_div)
        person = person.merge(person_info)

        return person
    end    

    def getHTMLDocument(url)
        document = ''

        begin
            document = Nokogiri::HTML(URI.open(@@base_url + url, :allow_redirections => :all))
            if document.title == 'Hasso-Plattner-Institut' # Redirect due to non-existance
                raise ScrapingException.new("Redirect")
            end
        rescue OpenURI::HTTPError => e
            raise ScrapingException.new("HTTPError")
        rescue SocketError => e
            raise ScrapingException.new("SocketError")
        end

        return document
    end

end