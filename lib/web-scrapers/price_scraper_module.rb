module PriceScraperModule
  
  # reload! ; load "lib/web-scrapers/price_scraper_module.rb" ; include PriceScraperModule ; PriceScraperModule.scrape_ean
  
  def self.scrape_ean(ean)
    prices  = {}

    # ean     = "1234567890123" # Fake EAN
    # ean     = "7501109901890" # Pariet
    # ean     = "7501008494226" # Aspirina
    # ean     = "7501299300367" # Sensibit

    # browser = Watir::Browser.new :chrome
    # browser = Watir::Browser.new :chrome, headless: true

    puts'------------------'
    puts Time.now.to_s + ' Starting Scrape for EAN: ' + ean
    # prices[:ahorro]       = scrape_ahorro(browser, ean)
    # prices[:by_price]     = scrape_by_price(browser, ean)
    # prices[:city_market]  = scrape_city_market(browser, ean)
    # prices[:farmalisto]   = scrape_farmalisto(browser, ean)
    # prices[:fresko]       = scrape_fresko(browser, ean)
    # prices[:guadalajara]  = scrape_guadalajara(browser, ean)
    # prices[:la_comer]     = scrape_la_comer(browser, ean)
    # prices[:prixz]        = scrape_prixz(browser, ean)
    # prices[:san_pablo]    = scrape_san_pablo(browser, ean)
    # prices[:soriana]      = scrape_soriana(browser, ean)
    # prices[:chedraui]     = scrape_chedraui(browser, ean)
    # prices[:superama]     = scrape_superama(browser, ean)
    # prices[:walmart]      = scrape_walmart(browser, ean)
    # prices[:sanborns]     = scrape_sanborns(browser, ean)

    puts Time.now.to_s + ' Ending Scrape for EAN: ' + ean 
    puts'------------------'
    # browser.close

    prices = {
      ahorro:       111.1,
      by_price:     444.4,
      city_market:  222.2,
      farmalisto:   333.3,
      fresko:       444.4,
      guadalajara:  555.5,
      la_comer:     666.6,
      prixz:        777.7,
      san_pablo:    888.8,
      soriana:      'Not In Store',
      chedraui:     999.9,
      superama:     'Not In Store',
      walmart:      0.0,
      sanborns:     'Other Error'
    }
  end

  def scrape_ahorro(browser, ean)
    puts Time.now.to_s + ' Scrapeando Ahorro'
    browser.goto 'https://www.fahorro.com/catalogsearch/result/?q=' + ean
    assign_price(browser.span(class: 'price'), browser.p(class: 'note-msg'))
  end

  def scrape_by_price(browser, ean)
    puts Time.now.to_s + ' Scrapeando By Price'
    start_url = 'https://byprice.com/busqueda?search-submit=&q=' + ean
    browser.goto start_url
    if browser.div(class: 'byprice-filters-title').p.wait_until(&:exists?).text.gsub(/[^\d]/, '').to_i > 0
      browser.button(class: 'byprice-button-2').wait_until(&:exists?).click until browser.url[20,8] != 'busqueda'
      browser.div(class: 'byprice-cards-list-item').span(class: 'ByPrice-price-amount').wait_until(&:exists?)
    end
    assign_price(browser.div(class: 'byprice-cards-list-item').span(class: 'ByPrice-price-amount'), browser.div(class: 'byprice-filters-title'))
  end

  def scrape_city_market(browser, ean)
    puts Time.now.to_s + ' Scrapeando City Market'
    browser.goto 'https://www.lacomer.com.mx/lacomer/goBusqueda.action?succId=380&ver=mislistas&succFmt=200&criterio=' + ean + '#/' + ean
    assign_price(browser.span(class: 'precio_normal'), browser.div(class: "sinresultados"))
  end

  def scrape_farmalisto(browser,ean)
    puts Time.now.to_s + ' Scrapeando Farmalisto'
    browser.goto 'https://www.farmalisto.com.mx/#/dffullscreen/query=' + ean + '&query_name=match_and'
    browser.div(class: 'df-header-title').wait_until(&:exists?)
    assign_price(browser.span(class: 'df-card__price'), browser.p(class: 'df-no-results'))
  end

  def scrape_fresko(browser, ean)
    puts Time.now.to_s + ' Scrapeando Fresko'
    browser.goto 'https://www.lacomer.com.mx/lacomer/goBusqueda.action?succId=137&ver=mislistas&succFmt=100&criterio=' + ean + '#/' + ean
    assign_price(browser.span(class: 'precio_normal'), browser.div(class: "sinresultados"))
  end

  def scrape_guadalajara(browser, ean)
    puts Time.now.to_s + ' Scrapeando Guadalajara'
    browser.goto 'https://www.farmaciasguadalajara.com/SearchDisplay?storeId=10151&searchTerm=' + ean
    assign_price(browser.span(class: 'price'), browser.div(class: 'widget_search_results'))
  end

  def scrape_la_comer(browser, ean)
    puts Time.now.to_s + ' Scrapeando La Comer'
    browser.goto 'https://www.lacomer.com.mx/lacomer/goBusqueda.action?succId=287&ver=mislistas&succFmt=100&criterio=' + ean + '#/' + ean
    assign_price(browser.span(class: 'precio_normal'), browser.div(class: "sinresultados"))
  end

  def scrape_prixz(browser, ean)
    puts Time.now.to_s + ' Scrapeando Prixz'
    browser.goto 'https://www.prixz.com/?s=' + ean + '&post_type=product'
    browser.div(id: 'algolia-hits').wait_until(&:exists?)

    if browser.div(class: "ais-hits__empty").exists?
      assign_price(browser.div(class: 'ais-hits--content'), browser.div(class: "ais-hits__empty"))
    else
      browser.div(class: 'ais-hits--content').h2.a.click
      browser.p(class: 'price').ins.wait_until(&:exists?)
      assign_price(browser.p(class: 'price').ins, browser.div(class: "ais-hits__empty"))
    end
  end

  def scrape_san_pablo(browser, ean)
    puts Time.now.to_s + ' Scrapeando San Pablo'
    browser.goto 'https://www.farmaciasanpablo.com.mx/search/?text=' + ean
    assign_price(browser.p(class: 'item-prize'), browser.div(class: 'search-empty'))
  end

  def scrape_soriana(browser, ean)
    puts Time.now.to_s + ' Scrapeando Soriana'
    browser.goto 'https://www.soriana.com/soriana/es/search/?text=' + ean
    assign_price(browser.ul(class: 'product__listing').span(class: 'price'), browser.div(class: 'searchEmptyPageMiddle-component'))
  end

  def scrape_chedraui(browser, ean)
    puts Time.now.to_s + ' Scrapeando Chedraui'
    browser.goto 'https://www.chedraui.com.mx/'
    browser.text_field(class: 'search__form--input').click
    browser.text_field(id: 'searchBox').set convert_ean_to_upc_12(ean)
    browser.send_keys :enter
    browser.header.wait_until(&:exists?)
    assign_price(browser.p(class: 'price'), browser.div(class: 'search-empty'))
  end

  def scrape_superama(browser, ean)
    puts Time.now.to_s + ' Scrapeando Superama'
    browser.goto 'https://www.superama.com.mx/buscar/' + convert_ean_to_upc_13(ean)
    assign_price(browser.p(class: 'upcPrice'), browser.span(class: 'numeroResultadosTotal'))
  end

  def scrape_walmart(browser, ean)
    puts Time.now.to_s + ' Scrapeando WalMart'
    browser.goto 'https://super.walmart.com.mx/productos?Ntt=' + convert_ean_to_upc_14(ean)
    browser.div(id: 'scrollToTopComponent').wait_until(&:exists?)
    browser.p(class: 'price-and-promotions_currentPrice__XT_Iz').wait_while { |a| a.text == '$--' } unless browser.div(class: 'no-results_container__75YGT').exists?
    assign_price(browser.p(class: 'price-and-promotions_currentPrice__XT_Iz'), browser.div(class: 'no-results_container__75YGT'))
  end

  def scrape_sanborns(browser, ean)
    puts Time.now.to_s + ' Scrapeando Sanbornns'
    browser.goto 'https://www.sanborns.com.mx/resultados/q=' + ean + '/1'
    price = assign_price(browser.span(class: 'preciodesc'), browser.div(class: 'resultado'))
    price.class.name == 'Float' ? (price * 100).round(2) : price
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

  def convert_ean_to_upc_13(ean)
    '0' + convert_ean_to_upc_12(ean)
  end

  def convert_ean_to_upc_14(ean)
    '00' + convert_ean_to_upc_12(ean)
  end
end