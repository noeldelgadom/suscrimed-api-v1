module PriceScraperModule
  
  # reload! ; load "lib/web-scrapers/price_scraper_module.rb" ; include PriceScraperModule ; PriceScraperModule.scrape_ean("1234567890")
  
  def self.scrape_ean(ean)
    prices  = {}

    # ean     = "1234567890123" # Fake EAN
    # ean     = "7501109901890" # Pariet
    # ean     = "7501008494226" # Aspirina Junior
    # ean     = "7501299300367" # Sensibit
    # ean     = "7501573902782" # RANITIDINA

    puts'------------------'
    puts Time.now.to_s + ' Starting Scrape for EAN: ' + ean

    browser = Watir::Browser.new :chrome
    # browser = Watir::Browser.new :chrome, headless: true

    prices = {
      ahorro:       'Not Updated',
      by_price:     'Not Updated',
      city_market:  'Not Updated',
      farmalisto:   'Not Updated',
      fresko:       'Not Updated',
      guadalajara:  'Not Updated',
      la_comer:     'Not Updated',
      prixz:        'Not Updated',
      san_pablo:    'Not Updated',
      soriana:      'Not Updated',
      chedraui:     'Not Updated',
      superama:     'Not Updated',
      walmart:      'Not Updated',
      sanborns:     'Not Updated',
    }

    prices[:ahorro]       = PriceScraperModule.scrape_ahorro(browser, ean)
    prices[:by_price]     = PriceScraperModule.scrape_by_price(browser, ean)
    prices[:city_market]  = PriceScraperModule.scrape_city_market(browser, ean)
    prices[:farmalisto]   = PriceScraperModule.scrape_farmalisto(browser, ean)
    prices[:fresko]       = PriceScraperModule.scrape_fresko(browser, ean)
    prices[:guadalajara]  = PriceScraperModule.scrape_guadalajara(browser, ean)
    prices[:la_comer]     = PriceScraperModule.scrape_la_comer(browser, ean)
    # prices[:prixz]        = PriceScraperModule.scrape_prixz(browser, ean)
    prices[:san_pablo]    = PriceScraperModule.scrape_san_pablo(browser, ean)
    prices[:soriana]      = PriceScraperModule.scrape_soriana(browser, ean)
    prices[:chedraui]     = PriceScraperModule.scrape_chedraui(browser, ean)
    prices[:superama]     = PriceScraperModule.scrape_superama(browser, ean)
    prices[:walmart]      = PriceScraperModule.scrape_walmart(browser, ean)
    prices[:sanborns]     = PriceScraperModule.scrape_sanborns(browser, ean)

    puts Time.now.to_s + ' Ending Scrape for EAN: ' + ean 
    puts'------------------'
    
    browser.close

    prices
  end

  def self.scrape_ahorro(browser, ean)
    puts Time.now.to_s + ' Scrapeando Ahorro'
    browser.goto 'https://www.fahorro.com/catalogsearch/result/?q=' + ean
    PriceScraperModule.assign_price(browser.span(class: 'price'), browser.p(class: 'note-msg'))
  end

  def self.scrape_by_price(browser, ean)
    puts Time.now.to_s + ' Scrapeando By Price'
    browser.goto 'https://byprice.com/busqueda?search-submit=&q=' + ean
    success_element = browser.div(class: 'some-weird-class-that-should-not-exist')
    if browser.div(class: 'byprice-filters-title').p.wait_until(&:exists?).text.gsub(/[^\d]/, '').to_i > 0
      browser.button(class: 'byprice-button-2').wait_until(&:exists?).click until browser.url[20,8] != 'busqueda'
      success_element = browser.div(class: 'ItemView-full-coverage-message').exists? ? browser.a(class: 'byprice-cards-list-item') : browser.div(class: 'byprice-cards-list-item')
      success_element = success_element.span(class: 'ByPrice-price-amount').wait_until(&:exists?)
    end
    PriceScraperModule.assign_price(success_element, browser.div(class: 'byprice-filters-title'))
  end

  def self.scrape_city_market(browser, ean)
    puts Time.now.to_s + ' Scrapeando City Market'
    browser.goto 'https://www.lacomer.com.mx/lacomer/goBusqueda.action?succId=380&ver=mislistas&succFmt=200&criterio=' + ean + '#/' + ean
    PriceScraperModule.assign_price(browser.span(class: 'precio_normal'), browser.div(class: "sinresultados"))
  end

  def self.scrape_farmalisto(browser,ean)
    puts Time.now.to_s + ' Scrapeando Farmalisto'
    browser.goto 'https://www.farmalisto.com.mx/#/dffullscreen/query=' + ean + '&query_name=match_and'
    browser.div(class: 'df-header-title').wait_until(&:exists?)
    PriceScraperModule.assign_price(browser.span(class: 'df-card__price'), browser.p(class: 'df-no-results'))
  end

  def self.scrape_fresko(browser, ean)
    puts Time.now.to_s + ' Scrapeando Fresko'
    browser.goto 'https://www.lacomer.com.mx/lacomer/goBusqueda.action?succId=137&ver=mislistas&succFmt=100&criterio=' + ean + '#/' + ean
    PriceScraperModule.assign_price(browser.span(class: 'precio_normal'), browser.div(class: "sinresultados"))
  end

  def self.scrape_guadalajara(browser, ean)
    puts Time.now.to_s + ' Scrapeando Guadalajara'
    browser.goto 'https://www.farmaciasguadalajara.com/SearchDisplay?storeId=10151&searchTerm=' + ean
    PriceScraperModule.assign_price(browser.span(class: 'price'), browser.div(class: 'widget_search_results'))
  end

  def self.scrape_la_comer(browser, ean)
    puts Time.now.to_s + ' Scrapeando La Comer'
    browser.goto 'https://www.lacomer.com.mx/lacomer/goBusqueda.action?succId=287&ver=mislistas&succFmt=100&criterio=' + ean + '#/' + ean
    PriceScraperModule.assign_price(browser.span(class: 'precio_normal'), browser.div(class: "sinresultados"))
  end

  def self.scrape_prixz(browser, ean)
    puts Time.now.to_s + ' Scrapeando Prixz'
    browser.goto 'https://www.prixz.com/?s=' + ean + '&post_type=product'
    browser.div(id: 'algolia-hits').wait_until(&:exists?)

    if browser.div(class: "ais-hits__empty").exists?
      PriceScraperModule.assign_price(browser.div(class: 'some-weird-class-that-should-not-exist'), browser.div(class: "ais-hits__empty"))
    else
      browser.div(class: 'ais-hits--content').h2.a.click

      if browser.section(class: 'not-found-page').exists?
        PriceScraperModule.assign_price(browser.p(class: 'some-weird-class-that-should-not-exist'), browser.section(class: 'not-found-page')) 
      else
        browser.p(class: 'price').ins.wait_until(&:exists?)
        PriceScraperModule.assign_price(browser.p(class: 'price').ins, browser.div(class: "ais-hits__empty"))
      end
    end
  end

  def self.scrape_san_pablo(browser, ean)
    puts Time.now.to_s + ' Scrapeando San Pablo'
    browser.goto 'https://www.farmaciasanpablo.com.mx/search/?text=' + ean
    PriceScraperModule.assign_price(browser.p(class: 'item-prize'), browser.div(class: 'search-empty'))
  end

  def self.scrape_soriana(browser, ean)
    puts Time.now.to_s + ' Scrapeando Soriana'
    browser.goto 'https://www.soriana.com/soriana/es/search/?text=' + ean
    PriceScraperModule.assign_price(browser.ul(class: 'product__listing').span(class: 'price'), browser.div(class: 'searchEmptyPageMiddle-component'))
  end

  def self.scrape_chedraui(browser, ean)
    puts Time.now.to_s + ' Scrapeando Chedraui'
    browser.goto 'https://www.chedraui.com.mx/'
    browser.text_field(class: 'search__form--input').click
    browser.text_field(id: 'searchBox').set PriceScraperModule.convert_ean_to_upc_12(ean)
    browser.send_keys :enter
    browser.header.wait_until(&:exists?)
    PriceScraperModule.assign_price(browser.p(class: 'price'), browser.div(class: 'search-empty'))
  end

  def self.scrape_superama(browser, ean)
    puts Time.now.to_s + ' Scrapeando Superama'
    browser.goto 'https://www.superama.com.mx/buscar/' + PriceScraperModule.convert_ean_to_upc_13(ean)

    if browser.p(class: 'upcPrice').exists?
      browser.p(class: 'upcPrice').text[(browser.p(class: 'upcPrice').span.text.length+1)..-1].gsub(/[^\d]/, '').to_f / 100
    elsif browser.span(class: 'numeroResultadosTotal').exists?
      'Not In Store'
    else
      'Other Error'
    end
  end

  def self.scrape_walmart(browser, ean)
    puts Time.now.to_s + ' Scrapeando WalMart'
    browser.goto 'https://super.walmart.com.mx/productos?Ntt=' + PriceScraperModule.convert_ean_to_upc_14(ean)
    browser.div(id: 'scrollToTopComponent').wait_until(&:exists?)
    browser.p(class: 'price-and-promotions_currentPrice__XT_Iz').wait_while { |a| a.text == '$--' } unless browser.div(class: 'no-results_container__75YGT').exists?
    PriceScraperModule.assign_price(browser.p(class: 'price-and-promotions_currentPrice__XT_Iz'), browser.div(class: 'no-results_container__75YGT'))
  end

  def self.scrape_sanborns(browser, ean)
    puts Time.now.to_s + ' Scrapeando Sanbornns'
    browser.goto 'https://www.sanborns.com.mx/resultados/q=' + ean + '/1'
    price = PriceScraperModule.assign_price(browser.span(class: 'preciodesc'), browser.div(class: 'resultado'))
    price.class.name == 'Float' ? (price * 100).round(2) : price
  end

  def self.assign_price(success_element, failure_element)

    if success_element.exists?
      success_element.text.gsub(/[^\d]/, '').to_f / 100
    elsif failure_element.exists?
      'Not In Store'
    else
      'Other Error'
    end
  end

  def self.convert_ean_to_upc_12(ean)
    ean.chop
  end

  def self.convert_ean_to_upc_13(ean)
    '0' + PriceScraperModule.convert_ean_to_upc_12(ean)
  end

  def self.convert_ean_to_upc_14(ean)
    '00' + PriceScraperModule.convert_ean_to_upc_12(ean)
  end
end