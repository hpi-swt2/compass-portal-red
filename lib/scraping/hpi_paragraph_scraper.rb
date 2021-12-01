require "#{Rails.root}/lib/scraping/hpi_web_scraper.rb"

class HpiParagraphScraper < HpiWebScraper
  @@delimiter = '***'

  def scrape
    item = {}

    item[:email] = @html.css('.mail').text

    p_tags = @html.css('p')
    p_tags.each do |p|
      # Converting each <br> to line breaks as p.text ignores <br> and inserts no whitespaces
      p.css('br').each do |node|
        node.replace(Nokogiri::XML::Text.new("\n#{@@delimiter}\n", p))
      end

      split_p = p.text.split(/[[:space:]]/)

      # Phone
      phone_words_intersection = split_p & @@phone_words # Check if one of those words is in split_p
      if phone_words_intersection.any?
        index = split_p.find_index(phone_words_intersection[0]) # Get the index of the first of those words
        split_p.delete(phone_words_intersection[0]) # Delete it

        phone_number = ''
        (index..(split_p.length - 1)).each do |n|
          # If next element starts with a number (or symbol) it has to be part of a phone number...
          break unless ([split_p[n][0]] & %w[- + ( 0 1 2 3 4 5 6 7 8 9]).any?

          phone_number = "#{phone_number}#{split_p[n]} "
        end

        item[:phone] = phone_number
      end

      # Office
      office_words_intersection = split_p & @@office_words
      if office_words_intersection.any?
        index = split_p.find_index(office_words_intersection[0])
        split_p.delete(office_words_intersection[0])

        # Get all words until line break
        office = ''
        while (split_p[index] != @@delimiter) && (index < split_p.length) do
            office = "#{office}#{split_p[index]} "
            index += 1
        end
        item[:office] = office       
      end

      # Email
      next unless item[:email] == ''

      # Pages that have their email not in a .mail class
      email_words_intersection = split_p & @@email_words
      next unless email_words_intersection.any?

      index = split_p.find_index(email_words_intersection[0])
      # In case the next elements are &nsbp;
      while item[:email] == ''
        index += 1
        item[:email] = split_p[index]
      end
    end

    item
  end

end

