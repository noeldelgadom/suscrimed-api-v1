module GoogleDriveModule
  require 'bundler'
  Bundler.require

  require_relative '../web-scrapers/price_scraper_module.rb'

  # reload! ; load "lib/google-drive/google-drive-module.rb" ; include GoogleDriveModule ; GoogleDriveModule.update_competitor_prices

  def self.update_competitor_prices
    session     = GoogleDrive::Session.from_service_account_key("config/api-keys/google-sheets-key.json")
    spreadsheet = session.spreadsheet_by_title("Competitor Prices")
    worksheet   = spreadsheet.worksheets.first

    puts'--------------------------------------------------------------------------------'
    puts'--------------------------------------------------------------------------------'
    puts Time.now.to_s + ' Start Updating Prices'

    row = 2
    while worksheet[row, 1] != ''
      ean     = worksheet[row, 1]
      puts Time.now.to_s + ' Updating EAN: ' + ean
      
      prices  = PriceScraperModule.scrape_ean(ean)

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

      row += 1
    end

    puts Time.now.to_s + ' Finish Updating Prices'
    puts'--------------------------------------------------------------------------------'
    puts'--------------------------------------------------------------------------------'
  end
end