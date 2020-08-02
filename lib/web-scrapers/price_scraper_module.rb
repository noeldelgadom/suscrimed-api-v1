module PriceScraperModule
  
  # reload! ; load "lib/web-scrapers/price_scraper_module.rb" ; include PriceScraperModule ; PriceScraperModule.scrape
  
  def self.scrape
    puts 'Starting Scrape'
    # ean     = "1234567890123" # Fake EAN
    # ean     = "7501109901890" # Pariet
    ean     = "7501314704644" # Durater
    browser = Watir::Browser.new

    prices  = {}
    prices[:ahorro]       = scrape_ahorro(browser, ean)
    # prices[:city_market]  = scrape_city_market(browser, ean)
    # prices[:farmalisto]   = scrape_farmalisto(browser, ean)
    # prices[:fresko]       = scrape_fresko(browser, ean)
    # prices[:guadalajara]  = scrape_guadalajara(browser, ean)

    byebug
    prices = {:ahorro=>111.0, :city_market=>222.0, :farmalisto=>333.0}
    browser.close
  end

  def scrape_ahorro(browser, ean)
    puts 'Scrapeando Ahorro. EAN: ' + ean
    browser.goto 'https://www.fahorro.com/catalogsearch/result/?q=' + ean
    price = assign_price(browser.span(class: 'price'), browser.p(class: 'note-msg'))
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

  def scrape_fresko(browser, ean)
    puts 'Scrapeando Fresko. EAN: ' + ean
    browser.goto 'https://www.lacomer.com.mx/lacomer/goBusqueda.action?succId=137&ver=mislistas&succFmt=100&criterio=' + ean + '#/' + ean
    price = assign_price(browser.span(class: 'precio_normal'))
  end

  def scrape_guadalajara(browser, ean)
    puts 'Scrapeando Fresko. EAN: ' + ean
    browser.goto 'https://www.farmaciasguadalajara.com/SearchDisplay?storeId=10151&searchTerm=' + ean
    price = assign_price(browser.span(class: 'price'))
  end

  def assign_price(success_element, failure_element)

    # success_element.wait_until(&:exists?)

    if success_element.exists?
      success_element.text.gsub(/[^\d]/, '').to_f / 100
    elsif failure_element.exists?
      'Not In Store'
    else
      'Other Error'
    end
  end
end