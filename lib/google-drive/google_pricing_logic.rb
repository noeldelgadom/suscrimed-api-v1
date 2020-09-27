module GooglePricingLogic
  require 'bundler'
  Bundler.require

  # reload! ; load "lib/google-drive/google_pricing_logic.rb" ; include GooglePricingLogic ; GooglePricingLogic.version_1

  def self.version_1
    session                       = GoogleDrive::Session.from_service_account_key("config/api-keys/google-sheets-key.json")
    competitor_prices_spreadsheet = session.spreadsheet_by_title("Competitor Prices")
    competitor_prices             = competitor_prices_spreadsheet.worksheets.fifth

    puts'--------------------------------------------------------------------------------'
    puts'--------------------------------------------------------------------------------'
    puts Time.now.to_s + ' Start Updating Google Prices'

    puts competitor_prices[2,3]

    puts Time.now.to_s + ' Finish Updating Google Prices'
    puts'--------------------------------------------------------------------------------'
    puts'--------------------------------------------------------------------------------'
  end
end