module PriceScraperModule
  
  # reload! ; load "lib/web-scrapers/price_scraper_module.rb" ; include PriceScraperModule ; PriceScraperModule.scrape
  
  def self.scrape
    puts 'Starting Scrape'
    ean     = "7501109901890"
    browser = Watir::Browser.new

    prices  = {}
    prices[:ahorro]       = scrape_ahorro(browser, ean)
    prices[:city_market]  = scrape_city_market(browser, ean)
    prices[:farmalisto]   = scrape_farmalisto(browser, ean)

    byebug
    prices = {:ahorro=>111.0, :city_market=>222.0, :farmalisto=>333.0}
    browser.close
  end

  def scrape_ahorro(browser, ean)
    puts 'Scrapeando Ahorro. EAN: ' + ean
    browser.goto 'https://www.fahorro.com/catalogsearch/result/?q=' + ean
    price = assign_price(browser.span(class: 'price'))
  end

  def scrape_city_market(browser, ean)
    puts 'Scrapeando City Market. EAN: ' + ean
    browser.goto 'https://www.lacomer.com.mx/lacomer/goBusqueda.action?succId=380&ver=mislistas&succFmt=200&criterio=' + ean + '#/' + ean
    price = assign_price(browser.span(class: 'precio_normal'))
  end

  def scrape_farmalisto(browser,ean)
    puts 'Scrapeando Farmalisto. EAN: ' + ean
    browser.goto 'https://www.farmalisto.com.mx/#/dffullscreen/query=' + ean + '&query_name=match_and'
    price = assign_price(browser.span(class: 'df-card__price'))
  end

  def assign_price(element)
    element.wait_until(&:exists?)
    element.exists? ? element.text.gsub(/[^\d]/, '').to_f / 100 : 9876543210
  end
end