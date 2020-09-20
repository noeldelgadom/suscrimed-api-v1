module GoogleDriveModule
  require 'bundler'
  Bundler.require

  require_relative '../web-scrapers/price_scraper_module.rb'
  require_relative '../web-scrapers/image_scraper_module.rb'

  # reload! ; load "lib/google-drive/google-drive-module.rb" ; include GoogleDriveModule ; GoogleDriveModule.update_competitor_prices

  def self.update_competitor_prices
    session                 = GoogleDrive::Session.from_service_account_key("config/api-keys/google-sheets-key.json")
    spreadsheet             = session.spreadsheet_by_title("Competitor Prices")
    worksheet_today_prices  = spreadsheet.worksheets.first
    worksheet_last_prices   = spreadsheet.worksheets.second

    puts'--------------------------------------------------------------------------------'
    puts'--------------------------------------------------------------------------------'
    puts Time.now.to_s + ' Start Updating Prices'

    row = 8001
    while worksheet_today_prices[row, 1] != '' && Time.now.hour < 21
      ean     = worksheet_today_prices[row, 1]
      puts Time.now.to_s + ' Updating EAN: ' + ean
      
      if '' == worksheet_today_prices[row, 3]
        prices  = PriceScraperModule.scrape_ean(ean)
        GoogleDriveModule.update_today_prices(row, prices, worksheet_today_prices)
        GoogleDriveModule.update_last_prices( row, prices, worksheet_last_prices )
      end

      row += 1
    end

    puts Time.now.to_s + ' Finish Updating Prices'
    puts'--------------------------------------------------------------------------------'
    puts'--------------------------------------------------------------------------------'
  end

  def self.update_today_prices(row, prices, worksheet)
    worksheet[row, 3]   = prices[:ahorro]
    worksheet[row, 4]   = prices[:by_price]
    worksheet[row, 5]   = prices[:city_market]
    worksheet[row, 6]   = prices[:farmalisto]
    worksheet[row, 7]   = prices[:fresko]
    worksheet[row, 8]   = prices[:guadalajara]
    worksheet[row, 9]   = prices[:la_comer]
    worksheet[row, 10]  = prices[:prixz]
    worksheet[row, 11]  = prices[:san_pablo]
    worksheet[row, 12]  = prices[:soriana]
    worksheet[row, 13]  = prices[:chedraui]
    worksheet[row, 14]  = prices[:superama]
    worksheet[row, 15]  = prices[:walmart]
    worksheet[row, 16]  = prices[:sanborns]  
    
    worksheet.save
  end

  def self.update_last_prices(row, prices, worksheet)
    worksheet[row, 3]   = prices[:ahorro]       if 'Float' == prices[:ahorro].class.name
    worksheet[row, 4]   = prices[:by_price]     if 'Float' == prices[:by_price].class.name
    worksheet[row, 5]   = prices[:city_market]  if 'Float' == prices[:city_market].class.name
    worksheet[row, 6]   = prices[:farmalisto]   if 'Float' == prices[:farmalisto].class.name
    worksheet[row, 7]   = prices[:fresko]       if 'Float' == prices[:fresko].class.name
    worksheet[row, 8]   = prices[:guadalajara]  if 'Float' == prices[:guadalajara].class.name
    worksheet[row, 9]   = prices[:la_comer]     if 'Float' == prices[:la_comer].class.name
    worksheet[row, 10]  = prices[:prixz]        if 'Float' == prices[:prixz].class.name
    worksheet[row, 11]  = prices[:san_pablo]    if 'Float' == prices[:san_pablo].class.name
    worksheet[row, 12]  = prices[:soriana]      if 'Float' == prices[:soriana].class.name
    worksheet[row, 13]  = prices[:chedraui]     if 'Float' == prices[:chedraui].class.name
    worksheet[row, 14]  = prices[:superama]     if 'Float' == prices[:superama].class.name
    worksheet[row, 15]  = prices[:walmart]      if 'Float' == prices[:walmart].class.name
    worksheet[row, 16]  = prices[:sanborns]     if 'Float' == prices[:sanborns].class.name
    
    worksheet.save
  end

  # reload! ; load "lib/google-drive/google-drive-module.rb" ; include GoogleDriveModule ; GoogleDriveModule.update_images

  def self.update_images
    session                 = GoogleDrive::Session.from_service_account_key("config/api-keys/google-sheets-key.json")
    spreadsheet             = session.spreadsheet_by_title("Competitor Images")
    worksheet_images        = spreadsheet.worksheets.first

    puts'--------------------------------------------------------------------------------'
    puts'--------------------------------------------------------------------------------'
    puts Time.now.to_s + ' Start Updating Images'

    browser = Watir::Browser.new :chrome
    # browser = Watir::Browser.new :chrome, headless: true

    row   = 2
    while worksheet_images[row, 1] != '' && Time.now.hour < 21
      ean     = worksheet_images[row, 1]
      puts Time.now.to_s + ' Updating EAN: ' + ean

      worksheet_images[row,3] = ImageScraperModule.scrape_ean(browser, ean) if '' == worksheet_images[row, 3]
      worksheet_images.save
      row += 1
    end
    browser.close

    puts Time.now.to_s + ' Finish Updating Images'
    puts'--------------------------------------------------------------------------------'
    puts'--------------------------------------------------------------------------------'
  end
end