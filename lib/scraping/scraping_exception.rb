class ScrapingException < StandardError
  def initialize(msg = "Scraping error", exception_type = "scraping error")
    @exception_type = exception_type
    super(msg)
  end
end
