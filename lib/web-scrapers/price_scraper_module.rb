module PriceScraperModule
  
  # reload! ; load "lib/web-scrapers/price_scraper_module.rb" ; include PriceScraperModule ; PriceScraperModule.scrape
  
  def self.scrape
    puts 'Starting Scrape'
    browser = Watir::Browser.new
    scrape_ahorro(browser)
  end

  def scrape_ahorro(browser)
    puts 'Scrapeando Ahorro'
    browser.goto 'https://www.fahorro.com/'
    browser.text_field(id: 'search').set "12345"
    byebug
    browser.close
  end
end