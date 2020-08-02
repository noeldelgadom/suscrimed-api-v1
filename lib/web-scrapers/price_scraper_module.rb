module PriceScraperModule
  
  # reload! ; load "lib/web-scrapers/price_scraper_module.rb" ; include PriceScraperModule ; PriceScraperModule.scrape
  
  def self.scrape
    puts 'Starting Scrape'
    ean     = "7501109901890"
    browser = Watir::Browser.new
    scrape_ahorro(browser, ean)
    browser.close
  end

  def scrape_ahorro(browser, ean)
    puts 'Scrapeando Ahorro'
    browser.goto 'https://www.fahorro.com/'
    browser.text_field(id: 'search').set ean
    browser.button(class: 'button').click
    browser.li(class: 'item').click

    if ean = browser.table(id: 'product-attribute-specs-table').tr(class: 'even').td.text
      price = browser.span(class: 'price').text.gsub(/[^\d]/, '').to_f / 100
    else
      price = 9876543210        # If this shows, up it means the EAN on the page is NOT the one we are looking for
    end
    return price
  end
end