module SearchScraperModule
  def self.scrape_ean(browser, ean)
    puts'------------------'
    puts Time.now.to_s + ' Starting Scrape for EAN: ' + ean

    search_object = {
      image_url:          'Not Updated',
      cofepris_code:      'Not Updated',
      friendly_title:     'Not Updated',
      active_ingredient:  'Not Updated',
      medical_condition:  'Not Updated',
    }

    search_object = SearchScraperModule.scrape_farmalisto(browser, ean, search_object)
    
    puts Time.now.to_s + ' Ending Scrape for EAN: ' + ean 
    puts'------------------'
    
    search_object
  end

  def self.scrape_farmalisto( browser, ean, search_object)
    puts Time.now.to_s + ' Scrapeando Farmalisto'
    browser.goto 'https://www.farmalisto.com.mx/#/dffullscreen/query=' + ean + '&query_name=match_and'
    browser.div(class: 'df-header-title').wait_until(&:exists?)
    if browser.a(class: 'df-card__main').exists?
      browser.a(class: 'df-card__main').click
      search_object[:image_url]           = browser.img(class: 'js-qv-product-cover').src   if browser.img(class: 'js-qv-product-cover').exists?
      search_object[:friendly_title]      = browser.h2(class: 'h1').text                    if browser.h2(class: 'h1').exists?
      search_object[:medical_condition]   = browser.ol.text.gsub("\n→ ", ">")               if browser.ol.exists?
      byebug
      if browser.div(id: 'product-description-short-570').exists?
        search_object[:cofepris_code]       = browser.div(id: 'product-description-short-570').text.last(14)
        search_object[:active_ingredient]   = browser.div(id: 'product-description-short-570').text[0..browser.div(id: 'product-description-short-570').text.index("\n")-1]        
      end
    end
    
    search_object
  end
end