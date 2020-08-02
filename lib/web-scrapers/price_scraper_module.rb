module PriceScraperModule
  
  # reload! ; load "lib/web-scrapers/price_scraper_module.rb" ; include PriceScraperModule ; PriceScraperModule.scrape
  
  def self.scrape
    puts 'Starting Scrape'
    ean     = "7501109901890"
    browser = Watir::Browser.new

    prices  = {}
    # prices[:ahorro]       = scrape_ahorro(browser, ean)
    # prices[:city_market]  = scrape_city_market(browser, ean)
    # prices[:farmalisto]   = scrape_farmalisto(browser, ean)

    prices = {:ahorro=>1114.0, :city_market=>1030.0, :farmalisto=>1025.0}
    browser.close
  end

  def scrape_ahorro(browser, ean)
    puts 'Scrapeando Ahorro. EAN: ' + ean
    browser.goto 'https://www.fahorro.com/catalogsearch/result/?q=' + ean
    price = clean_price(browser.span(class: 'price').text)
  end

  def scrape_city_market(browser, ean)
    puts 'Scrapeando City Market. EAN: ' + ean
    browser.goto 'https://www.lacomer.com.mx/lacomer/goBusqueda.action?succId=380&ver=mislistas&succFmt=200&criterio=' + ean + '#/' + ean
    price = clean_price(browser.span(class: 'precio_normal').text)
  end

  def scrape_farmalisto(browser,ean)
    puts 'Scrapeando Farmalisto. EAN: ' + ean
    browser.goto 'https://www.farmalisto.com.mx/#/dffullscreen/query=' + ean + '&query_name=match_and'
    price = clean_price(browser.span(class: 'df-card__price').text)
  end

  def clean_price(text)
    text.gsub(/[^\d]/, '').to_f / 100
  end
end