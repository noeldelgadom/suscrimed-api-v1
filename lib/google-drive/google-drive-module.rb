module GoogleDriveModule
  require 'bundler'
  Bundler.require

  require_relative '../web-scrapers/price_scraper_module.rb'

  # reload! ; load "lib/google-drive/google-drive-module.rb" ; include GoogleDriveModule ; GoogleDriveModule.update_prices

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
    puts'--------------------------------------------------------------------------------'
    puts'--------------------------------------------------------------------------------'
    puts Time.now.to_s + ' Start Updating Prices'
    # session     = GoogleDrive::Session.from_service_account_key("config/api-keys/google-sheets-key.json")
    # spreadsheet = session.spreadsheet_by_title("Competitor Prices")
    # worksheet   = spreadsheet.worksheets.first

    # row = 2
    # while worksheet[row,1] != ""

      ean     = "7501109901890" # Pariet
      puts ean
      prices = PriceScraperModule.scrape_ean(ean)

    #   row += 1
    # end
    byebug
    puts Time.now.to_s + ' Finish Updating Prices'
    puts'--------------------------------------------------------------------------------'
    puts'--------------------------------------------------------------------------------'
  end
end