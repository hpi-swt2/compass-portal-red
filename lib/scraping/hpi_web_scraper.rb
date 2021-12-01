require "#{Rails.root}/lib/scraping/scraping_exception.rb"

# "Abstract" class
class HpiWebScraper
  @@phone_words = %w[Tel.: Telefon: telephone: Telephone: phone: Phone: Phone.:]
  @@office_words = %w[office: Office: Raum: Room:]
  @@email_words = %w[Email: E-mail: E-Mail:]

  @@base_url = 'https://hpi.de'

  def initialize(html_document)
    @html = html_document
  end

  def scrape
    raise "Function has to be overridden."
  end

  def download_image(person_image_div)
    image = person_image_div.at_css('img')
    unless image
      # No image on website
      return
    end

    img_src = image.attr('src')
    img_src = @@base_url + img_src

    get_image_file_path(img_src)
  end

  def get_image_file_path(img_src)
    # Get the file name without complete file path
    index = img_src.rindex("/")
    file_name = img_src[index + 1, img_src.length - 1]

    relative_file_path = "/app/assets/images/people/#{file_name}"
    file_path = "#{Rails.root}#{relative_file_path}"
    File.open(file_path, 'wb') do |f|
      f.write open(img_src).read
    end

    relative_file_path
  end

end
