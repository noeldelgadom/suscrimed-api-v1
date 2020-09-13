module ImageScraperModule
  
  # reload! ; load "lib/web-scrapers/price_scraper_module.rb" ; include PriceScraperModule ; PriceScraperModule.scrape_ean("1234567890123")      # Fake EAN
  
  def self.scrape_ean(browser, ean)
    puts'------------------'
    puts Time.now.to_s + ' Starting Scrape for EAN: ' + ean

    data = {
      image_url:  '',
      source:     ''
    }

    data[:image_url] = ImageScraperModule.scrape_ahorro(browser, ean)
    data[:source]    = 'Ahorro' if data[:image_url] != ''
    
    puts Time.now.to_s + ' Ending Scrape for EAN: ' + ean 
    puts'------------------'

    data
  end

  def self.scrape_ahorro(browser, ean)
    puts Time.now.to_s + ' Scrapeando Ahorro'
    browser.goto 'https://www.fahorro.com/catalogsearch/result/?q=' + ean
    browser.img(class: 'product-image-photo').exists? ? browser.img(class: 'product-image-photo').src : ''
  end
end