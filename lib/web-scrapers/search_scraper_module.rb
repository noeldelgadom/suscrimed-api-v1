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
    
    puts Time.now.to_s + ' Ending Scrape for EAN: ' + ean 
    puts'------------------'
    
    return search_object
  end
end