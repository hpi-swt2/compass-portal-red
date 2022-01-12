require_relative "scraping_exception"

# "Abstract" class
class HpiWebScraper
  PHONE_WORDS = %w[Tel.: Telefon: telephone: Telephone: phone: Phone: Phone.: Tel:].freeze
  OFFICE_WORDS = %w[office: Office: Raum: Room:].freeze
  EMAIL_WORDS = %w[Email: E-mail: E-Mail: e-mail:].freeze

  BASE_URL = 'https://hpi.de'.freeze

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
    img_src = BASE_URL + img_src

    get_image_file_path_and_save(img_src)
  end

  private

  def get_image_file_path_and_save(img_src)
    # Get the file name without complete file path
    index = img_src.rindex("/")
    file_name = img_src[index + 1, img_src.length - 1]

    relative_file_path = "/assets/images/people/#{file_name}"
    more_relative_file_path = "public#{relative_file_path}"
    file_path = Rails.root.join(more_relative_file_path)
    File.open(file_path, 'wb') do |f|
      f.write URI(img_src).open.read
    end

    return "/assets/people/#{file_name}"
  end
end
