module GoogleDriveModule
  require 'bundler'
  Bundler.require

  require_relative '../web-scrapers/price_scraper_module.rb'

  # reload! ; load "lib/google-drive/google-drive-module.rb" ; include GoogleDriveModule ; GoogleDriveModule.update_competitor_prices

  def first_try
    session     = GoogleDrive::Session.from_service_account_key("config/api-keys/google-sheets-key.json")
    spreadsheet = session.spreadsheet_by_title("Practice API")
    worksheet   = spreadsheet.worksheets.first
    worksheet.rows.first(3).each_with_index do |row, i|
      worksheet[i + 1,2] = i + 1
    end

    worksheet.save

  end

  def self.update_competitor_prices
    session     = GoogleDrive::Session.from_service_account_key("config/api-keys/google-sheets-key.json")
    spreadsheet = session.spreadsheet_by_title("Competitor Prices")
    worksheet   = spreadsheet.worksheets.first

    puts'--------------------------------------------------------------------------------'
    puts'--------------------------------------------------------------------------------'
    puts Time.now.to_s + ' Start Updating Prices'

    row     = 2
    ean     = worksheet[row, 1] # Pariet
    puts Time.now.to_s + ' Updating EAN: ' + ean
    prices  = PriceScraperModule.scrape_ean(ean)


    byebug
    puts Time.now.to_s + ' Finish Updating Prices'
    puts'--------------------------------------------------------------------------------'
    puts'--------------------------------------------------------------------------------'
  end
end