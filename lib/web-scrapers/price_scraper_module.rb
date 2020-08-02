module PriceScraperModule
  
  # reload! ; load "lib/web-scrapers/price_scraper_module.rb" ; include PriceScraperModule ; PriceScraperModule.scrape
  
  def self.scrape
    puts 'Starting Scrape'
    ean     = "7501109901890"
    browser = Watir::Browser.new
    scrape_ahorro(browser, ean)
  end

  def scrape_ahorro(browser, ean)
    puts 'Scrapeando Ahorro'
    browser.goto 'https://www.fahorro.com/'
    browser.text_field(id: 'search').set ean
    browser.button(class: 'button').click
    browser.li(class: 'item').click

    if ean = browser.table(id: 'product-attribute-specs-table').tr(class: 'even').td.text
      puts 'Success! EAN matches'
      byebug
    else
      puts 'Error! EAN on the page is NOT the one we are looking for'
    end
    browser.close
  end
end