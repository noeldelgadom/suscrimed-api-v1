module PriceScraperModule
  
  # reload! ; load "lib/web-scrapers/price_scraper_module.rb" ; include PriceScraperModule ; PriceScraperModule.scrape
  
  def self.scrape
    puts 'Starting Scrape'
    ean     = "7501109901890"
    browser = Watir::Browser.new

    prices  = {}
    prices[:ahorro]       = scrape_ahorro(browser, ean)
    prices[:city_market]  = scrape_city_market(browser, ean)

    byebug
    browser.close
  end

  def scrape_ahorro(browser, ean)
    puts 'Scrapeando Ahorro'
    browser.goto 'https://www.fahorro.com/catalogsearch/result/?q=' + ean
    price = clean_price(browser.span(class: 'price').text)
  end

  def scrape_city_market(browser, ean)
    puts 'Scrapeando City Market'
    browser.goto 'https://www.lacomer.com.mx/lacomer/goBusqueda.action?succId=380&ver=mislistas&succFmt=200&criterio=' + ean + '#/' + ean
    price = clean_price(browser.span(class: 'precio_normal').text)
  end

  def clean_price(text)
    text.gsub(/[^\d]/, '').to_f / 100
  end
end