module PriceScraperModule
  
  # reload! ; load "lib/web-scrapers/price_scraper_module.rb" ; include PriceScraperModule ; PriceScraperModule.scrape
  
  def self.scrape
    puts 'Starting Scrape'
    ean     = "1234567890123" # Fake EAN
    # ean     = "7501109901890" # Pariet
    # ean     = "7501008494226" # Aspirina
    # ean     = "7501299300367" # Sensibit
    browser = Watir::Browser.new

    prices  = {}
    # prices[:ahorro]       = scrape_ahorro(browser, ean)
    # prices[:city_market]  = scrape_city_market(browser, ean)
    # prices[:farmalisto]   = scrape_farmalisto(browser, ean)
    # prices[:fresko]       = scrape_fresko(browser, ean)
    # prices[:guadalajara]  = scrape_guadalajara(browser, ean)
    # prices[:la_comer]     = scrape_la_comer(browser, ean)
    # prices[:prixz]        = scrape_prixz(browser, ean)
    # prices[:san_pablo]    = scrape_san_pablo(browser, ean)
    # prices[:soriana]      = scrape_soriana(browser, ean)

    prices[:chedraui]      = scrape_chedraui(browser, ean)

    byebug
    prices = {
      ahorro:       111.0,
      city_market:  222.0,
      farmalisto:   333.0,
      fresko:       444.0,
      guadalajara:  555.00,
      la_comer:     666.00,
      prixz:        777.00,
      san_pablo:    888.00
    }
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
    price = assign_price(browser.span(class: 'precio_normal'), browser.div(class: "sinresultados"))
  end

  def scrape_farmalisto(browser,ean)
    puts 'Scrapeando Farmalisto. EAN: ' + ean
    browser.goto 'https://www.farmalisto.com.mx/#/dffullscreen/query=' + ean + '&query_name=match_and'
    browser.div(class: 'df-header-title').wait_until(&:exists?)
    price = assign_price(browser.span(class: 'df-card__price'), browser.p(class: 'df-no-results'))
  end

  def scrape_fresko(browser, ean)
    puts 'Scrapeando Fresko. EAN: ' + ean
    browser.goto 'https://www.lacomer.com.mx/lacomer/goBusqueda.action?succId=137&ver=mislistas&succFmt=100&criterio=' + ean + '#/' + ean
    price = assign_price(browser.span(class: 'precio_normal'), browser.div(class: "sinresultados"))
  end

  def scrape_guadalajara(browser, ean)
    puts 'Scrapeando Fresko. EAN: ' + ean
    browser.goto 'https://www.farmaciasguadalajara.com/SearchDisplay?storeId=10151&searchTerm=' + ean
    price = assign_price(browser.span(class: 'price'), browser.div(class: 'widget_search_results'))
  end

  def scrape_la_comer(browser, ean)
    puts 'Scrapeando La Comer. EAN: ' + ean
    browser.goto 'https://www.lacomer.com.mx/lacomer/goBusqueda.action?succId=287&ver=mislistas&succFmt=100&criterio=' + ean + '#/' + ean
    price = assign_price(browser.span(class: 'precio_normal'), browser.div(class: "sinresultados"))
  end

  def scrape_prixz(browser, ean)
    puts 'Scrapeando Prixz. EAN: ' + ean
    browser.goto 'https://www.prixz.com/?s=' + ean + '&post_type=product'

    if browser.div(class: "ais-hits__empty").exists?
      price = assign_price(browser.div(class: 'ais-hits--content'), browser.div(class: "ais-hits__empty"))
    else
      browser.div(class: 'ais-hits--content').h2.a.click
      browser.p(class: 'price').ins.wait_until(&:exists?)
      price = assign_price(browser.p(class: 'price').ins, browser.div(class: "ais-hits__empty"))
    end
  end

  def scrape_san_pablo(browser, ean)
    puts 'Scrapeando San Pablo. EAN: ' + ean
    browser.goto 'https://www.farmaciasanpablo.com.mx/search/?text=' + ean
    price = assign_price(browser.p(class: 'item-prize'), browser.div(class: 'search-empty'))
  end

  def scrape_soriana(browser, ean)
    puts 'Scrapeando Soriana. EAN: ' + ean
    browser.goto 'https://www.soriana.com/soriana/es/search/?text=' + ean
    price = assign_price(browser.ul(class: 'product__listing').span(class: 'price'), browser.div(class: 'searchEmptyPageMiddle-component'))
  end

  def scrape_chedraui(browser, ean)
    puts 'Scrapeando Chedraui. EAN: ' + ean
    utc_12 = convert_ean_to_upc_12(ean)
    puts ean
    puts utc_12
  end

  def assign_price(success_element, failure_element)

    if success_element.exists?
      success_element.text.gsub(/[^\d]/, '').to_f / 100
    elsif failure_element.exists?
      'Not In Store'
    else
      'Other Error'
    end
  end

  def convert_ean_to_upc_12(ean)
    ean.chop
  end
end