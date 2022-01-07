require_relative "hpi_web_scraper"

class HpiParagraphScraper < HpiWebScraper
  DELIMITER = '***'.freeze

  def scrape
    item = {}

    p_tags = @html.css('p')
    p_tags.each do |p|
      # Converting each <br> to delimiter as p.text ignores <br> and inserts no whitespaces
      p.css('br').each do |node|
        node.replace(Nokogiri::XML::Text.new("\n#{DELIMITER}\n", p))
      end
    end

    item[:phone] = scrape_phone(p_tags, item)
    item[:office] = scrape_office(p_tags, item)

    # Check the whole document for a `.mail` tag
    item[:email] = @html.at_css('.mail')&.text
    # In case '.mail' class does not exist on the whole web page
    # rubocop:disable Style/IfUnlessModifier
    if item[:email] == ''
      item[:email] = scrape_mail(p_tags, item)
    end
    # rubocop:enable Style/IfUnlessModifier
    item
  end

  private

  def scrape_phone(p_tags, item)
    p_tags.each do |p|

      split_p = p.text.split(/[[:space:]]/)

      phone_words_intersection = split_p & PHONE_WORDS # Check if one of those words is in split_p
      next unless phone_words_intersection.any?

      index = split_p.find_index(phone_words_intersection[0]) # Get the index of the first of those words
      split_p.delete(phone_words_intersection[0]) # Delete it

      phone_number = ''
      (index..(split_p.length - 1)).each do |n|
        # If next element starts with a number (or symbol) it has to be part of a phone number...
        break unless ([split_p[n][0]] & %w[- + ( 0 1 2 3 4 5 6 7 8 9]).any? || split_p[n] == ''

        phone_number = "#{phone_number}#{split_p[n]} "
      end

      item[:phone] = phone_number
    end

    item[:phone]
  end

  def scrape_office(p_tags, item)
    p_tags.each do |p|

      split_p = p.text.split(/[[:space:]]/)

      office_words_intersection = split_p & OFFICE_WORDS
      next unless office_words_intersection.any?

      index = split_p.find_index(office_words_intersection[0])
      split_p.delete(office_words_intersection[0])

      # Get all words until line break
      office = ''
      while (split_p[index] != DELIMITER) && (index < split_p.length)
        office = "#{office}#{split_p[index]} "
        index += 1
      end
      item[:office] = office

    end

    item[:office]
  end

  def scrape_mail(p_tags, item)
    p_tags.each do |p|

      split_p = p.text.split(/[[:space:]]/)

      email_words_intersection = split_p & EMAIL_WORDS
      next unless email_words_intersection.any?

      index = split_p.find_index(email_words_intersection[0])
      # In case the next elements are &nbsp; or whitespaces within email
      while item[:email] == '' || ((item[:email].exclude? '.de') && (item[:email].exclude? '.com'))
        index += 1

        break if index >= split_p.length

        item[:email] += split_p[index] if split_p[index] != ' '
      end
    end

    item[:email]
  end
end
