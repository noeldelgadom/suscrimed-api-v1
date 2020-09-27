module GooglePricingLogic
  require 'bundler'
  Bundler.require

  # reload! ; load "lib/google-drive/google_pricing_logic.rb" ; include GooglePricingLogic ; GooglePricingLogic.version_1

  def self.version_1
    # session                       = GoogleDrive::Session.from_service_account_key("config/api-keys/google-sheets-key.json")
    # competitor_prices_spreadsheet = session.spreadsheet_by_title("Competitor Prices")
    # competitor_prices             = competitor_prices_spreadsheet.worksheets.fifth
    # nadro_spreadsheet             = session.spreadsheet_by_title("NADRO - CATALAGO DE PRODUCTOS NADRO AL 200712")
    # nadro_costs                   = nadro_spreadsheet.worksheets.first
    # webflow_spreadsheet           = session.spreadsheet_by_title("Webflow Product Import")
    # webflow_import                = webflow_spreadsheet.worksheets.first

    puts'--------------------------------------------------------------------------------'
    puts'--------------------------------------------------------------------------------'
    puts Time.now.to_s + ' Start Updating Google Prices'

    # puts competitor_prices[2,3]
    # puts nadro_costs[7,3]
    # puts webflow_import[1,1]

    farmalisto_price  = 12.0
    price_max_limit   = 15.0
    cost              = 10.0
    
    price             = farmalisto_price
    margin            = (price - cost) / cost

    puts margin


    puts Time.now.to_s + ' Finish Updating Google Prices'
    puts'--------------------------------------------------------------------------------'
    puts'--------------------------------------------------------------------------------'
  end
end