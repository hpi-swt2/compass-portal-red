require "#{Rails.root}/lib/scraping/scraping_exception.rb"
require "#{Rails.root}/lib/scraping/hpi_table_scraper.rb"
require "#{Rails.root}/lib/scraping/hpi_paragraph_scraper.rb"

class HpiDataCollector
    @@title_words = ['Prof.', 'Dr.']

    def initialize(base_url='https://hpi.de')
        @base_url = base_url
    end

    def getNames(name)
        person = {}

        name_list = name.split()
        filtered_name_list = name_list - @@title_words

        person[:surname] = filtered_name_list.first
        person[:name] = filtered_name_list.last

        return person
    end

    def getTitle(name)
        person = {}

        name_list = name.split()
        titles_list = name_list & @@title_words
        person[:title] = titles_list.join(" ")

        return person
    end

    def getScrapingInfo(name, url)
        person = {}

        document = getHTMLDocument(url)

        # Get divs that contain the data
        content = document.css('#content')
        person_div = content.css('.csc-textpic')
        person_text_div = person_div.css('.csc-textpic-text')
        person_image_div = person_div.css('.csc-textpic-imagewrap')

        person_info = {}
        scraper = ""

        # Page contains table
        if person_text_div.css('table').any? then
            scraper = HpiTableScraper.new(person_text_div)
        # Page contains multiple people
        elsif person_text_div.length > 1 then
            name_header = content.at("h2:contains('#{name}')")

            if !name_header then # Some pages have the peoples' names in h3 not in h2
                name_header = content.at("h3:contains('#{name}')")
            end

            if name_header then
                person_text_div = name_header.parent.parent.parent
                person_image_div = person_text_div.previous
            end

            scraper = HpiParagraphScraper.new(person_text_div)
        # Page contains paragraphs
        else
            scraper = HpiParagraphScraper.new(person_text_div)
        end

        person[:website] = @base_url + url
        person_info = scraper.scrape()
        if person_image_div then
            person[:image] = scraper.downloadImage(person_image_div)
        end
        person = person.merge(person_info)

        return person
    end    

    def getHTMLDocument(url)
        document = ''

        begin
            document = Nokogiri::HTML(URI.open(@base_url + url, :allow_redirections => :all))
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