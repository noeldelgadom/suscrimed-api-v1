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


    puts 'Cost | Max_limit | Limit_Margin | Price | Price_Margin | Farmalisto | Farmalisto_Margin'
    row       = 1
    row_limit = 20
    while row < row_limit

      cost              = rand(1..100) / 1.0

      max_limit         = rand(1..100) / 1.0
      limit_margin      = (100 * (max_limit - cost) / cost).round(2)

      price             = rand(1..100) / 1.0
      price_margin      = (100 * (price - cost) / cost).round(2)

      farmalisto_price  = [rand(1..100) / 1.0, 'Not In Store', '' ].sample
      farmalisto_margin = farmalisto_price.class.name == 'String' ? 'NA' : (100 * (farmalisto_price - cost) / cost).round(2)
            

      print cost
      print '    |    '
      print max_limit
      print '    |    '
      print limit_margin
      print '    |    '
      print price
      print '    |    '
      print price_margin
      print '    |    '
      print farmalisto_price
      print '    |    '
      print farmalisto_margin
      puts
      
      row += 1
    end


    puts Time.now.to_s + ' Finish Updating Google Prices'
    puts'--------------------------------------------------------------------------------'
    puts'--------------------------------------------------------------------------------'
  end
end