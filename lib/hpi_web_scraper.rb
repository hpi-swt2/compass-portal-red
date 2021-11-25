class HpiWebScraper
    @phone_words = ['Tel.:', 'Telefon:', 'telephone:', 'Telephone:', 'phone:', 'Phone:', 'Phone.:']
    @office_words = ['office:', 'Office:', 'Raum:', 'Room:']
    @email_words = ['Email:', 'E-mail:', 'E-Mail:']
    
    base_url = 'https://hpi.de'

    def getNames (name)
        item = {}

        name_list = name.split()
        filtered_name_list = name_list - ['Prof.', 'Dr.']

        item[:surname] = filtered_name_list.first
        item[:name] = filtered_name_list.last

        return item
    end

    def getScrapingInfo (url)
        item = {}
        return item
    end
end