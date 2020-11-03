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

    search_object = SearchScraperModule.scrape_farmalisto( browser, ean, search_object)
    
    puts Time.now.to_s + ' Ending Scrape for EAN: ' + ean 
    puts'------------------'
    
    return search_object
  end

  def self.scrape_farmalisto( browser, ean, search_object)
    puts 'Entering Farmalisto'
    puts search_object
    puts 'Leaving Farmalisto'
  end
end