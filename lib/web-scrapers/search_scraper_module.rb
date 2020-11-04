module SearchScraperModule
  def self.scrape_ean(browser, ean)
    puts'------------------'
    puts Time.now.to_s + ' Starting Scrape for EAN: ' + ean

    search_object = {
      image_url_fl:         'Not Updated',
      cofepris_code:        'Not Updated',
      friendly_title_fl:    'Not Updated',
      active_ingredient_fl: 'Not Updated',
      medical_condition:    'Not Updated',
      image_url_sp:         'Not Updated',
      friendly_title_sp:    'Not Updated',
      active_ingredient_sp: 'Not Updated',
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
      search_object[:image_url_fl]        = browser.img(class: 'js-qv-product-cover').src   if browser.img(class: 'js-qv-product-cover').exists?
      search_object[:friendly_title_fl]   = browser.h2(class: 'h1').text                    if browser.h2(class: 'h1').exists?
      search_object[:medical_condition]   = browser.ol.text.gsub("\n→ ", ">")               if browser.ol.exists?
      
      if search_object[:active_ingredient_fl]   = browser.div(class: 'product-information').exists?
        search_object[:active_ingredient_fl]    = browser.div(class: 'product-information').text[0..browser.div(class: 'product-information').text.index("\n")-1]
      
        if browser.div(class: 'product-information').text.include?("COFEPRIS")
          start_pos =   browser.div(class: 'product-information').text.index("COFEPRIS")  + 10
          end_pos   =   browser.div(class: 'product-information').text.index("SSA")       - 2
          end_pos   +=  1 unless " " == browser.div(class: 'product-information').text[end_pos+1] 
          search_object[:cofepris_code]     = browser.div(class: 'product-information').text[start_pos..end_pos]
        end
      end

    end
    
    search_object
  end
end