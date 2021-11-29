require "#{Rails.root}/lib/scraping_exception.rb"
require "#{Rails.root}/lib/hpi_table_scraper.rb"
require "#{Rails.root}/lib/hpi_paragraph_scraper.rb"

class HpiDataCollector
    @@phone_words = ['Tel.:', 'Telefon:', 'telephone:', 'Telephone:', 'phone:', 'Phone:', 'Phone.:']
    @@office_words = ['office:', 'Office:', 'Raum:', 'Room:']
    @@email_words = ['Email:', 'E-mail:', 'E-Mail:']
    
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

        # Scrape websites
        document = getHTMLDocument(url)

        # Get divs that contain the data
        person_div = document.css('.csc-textpic')
        person_text_div = person_div.css('.csc-textpic-text')
        person_image_div = person_div.css('.csc-textpic-imagewrap')

        person[:email] = person_text_div.css('.mail').text

        person_info = {}
        # Page contains table
        if person_text_div.css('table').any? then
            tableScraper = HpiTableScraper.new(person_text_div)
            person_info = tableScraper.scrape()
        end
        # Page contains paragraphs instead
        else
            paragraphScraper = HpiParagraphScraper.new(person_text_div)
            person_info = paragraphScraper.new(person_text_div)
        end
        # Page contains multiple people
        # TODO

        person = person.merge(person_info)

        # Download and save image
        # person[:image] = downloadImage(person_image_div)

        return person
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