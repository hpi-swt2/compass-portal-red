class HpiWebScraper
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
        
        # Check doc.
        # TODO

        # Get divs that contain the data
        person_div = document.css('.csc-textpic')
        person_text_div = person_div.css('.csc-textpic-text')
        person_image_div = person_div.css('.csc-textpic-imagewrap')

        person[:email] = person_text_div.css('.mail').text

        person_info = {}
        # Page contains table
        if person_text_div.css('table').any? then
            person_info = scrapeTable()
        end
        # Page contains paragraphs instead
        else
            person_info = scrapeParagraph()
        end
        # Page contains multiple people
        # TODO

        person = person.merge(person_info)

        # Download and save image
        # TODO

        return person
    end

    def getHTMLDocument(url)
        document = ''

        begin
            document = Nokogiri::HTML(URI.open(@@base_url + url, :allow_redirections => :all))
            if document.title == 'Hasso-Plattner-Institut' # Redirect due to non-existance
                # TODO
            end
        rescue OpenURI::HTTPError => e
            # TODO
        rescue SocketError => e
            # TODO
        end

        return document
    end

    def scrapeTable
        item = {}

        td_tags = person_text_div.css('td')
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

        return item
    end

    def scrapeParagraph
        item = {}

        p_tags = person_text_div.css('p')
        p_tags.each do |p|
            # Converting each <br> to line breaks as p.text ignores <br> and inserts no whitespaces
            p.css('br').each do |node|
                node.replace(Nokogiri::XML::Text.new("\n", p))
            end

            split_p = p.text.split(/[[:space:]]/)

            # Phone
            phone_words_intersection = split_p & @@phone_words  # Check if one of those words is in split_p
            if phone_words_intersection.any? then 
                index = split_p.find_index(phone_words_intersection[0]) # Get the index of the first of those words
                split_p.delete(phone_words_intersection[0]) # Delete it
                
                phone_number = ''
                (index..(split_p.length-1)).each do |n|
                    if ([split_p[n][0]] & ['-', '+', '(', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9']).any? then # If next element starts with a number (or symbol) it has to be part of a phone number...
                        phone_number = phone_number + split_p[n] + ' '
                    else
                        break
                    end
                end
                
                item[:phone] = phone_number
            end

            # Office
            office_words_intersection = split_p & @@office_words
            if office_words_intersection.any? then
                index = split_p.find_index(office_words_intersection[0])
                split_p.delete(office_words_intersection[0])
                item[:office] = split_p[index]
            end

            # Email
            if item[:email] == '' then # Pages that have their email not in a .mail class
                email_words_intersection = split_p & @@email_words
                if email_words_intersection.any? then
                    index = split_p.find_index(email_words_intersection[0])

                    # In case the next elements are &nsbp;
                    while (item[:email] == '') do
                        index = index + 1
                        item[:email] = split_p[index]
                    end 
                end
            end
        end

        return item
    end
end