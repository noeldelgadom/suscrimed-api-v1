module GooglePricingLogic
  require 'bundler'
  Bundler.require

  # reload! ; load "lib/google-drive/google_pricing_logic.rb" ; include GooglePricingLogic ; GooglePricingLogic.version_1

  def self.version_1
    session                       = GoogleDrive::Session.from_service_account_key("config/api-keys/google-sheets-key.json")
    competitor_prices_spreadsheet = session.spreadsheet_by_title("Competitor Prices")
    competitor_prices             = competitor_prices_spreadsheet.worksheets.fifth
    nadro_spreadsheet             = session.spreadsheet_by_title("NADRO - CATALAGO DE PRODUCTOS NADRO AL 200712")
    nadro_costs                   = nadro_spreadsheet.worksheets.first
    webflow_spreadsheet           = session.spreadsheet_by_title("Webflow Product Import")
    webflow_import                = webflow_spreadsheet.worksheets.first

    puts'--------------------------------------------------------------------------------'
    puts'--------------------------------------------------------------------------------'
    puts Time.now.to_s + ' Start Updating Google Prices'


    puts 'Cost | Max_limit | Limit_Margin | Price | Price_Margin | Farmalisto | Farmalisto_Margin'
    row           = 1
    save_interval = 10
    while webflow_import[row + 1, 1] != ''
      cost              = nadro_costs[row + 6, 7]
      max_limit         = nadro_costs[row + 6, 8]
      farmalisto_price  = competitor_prices[row + 1, 3]
      
      if farmalisto_price.class.name == 'Float' && cost < farmalisto_price && farmalisto_price < max_limit
        price = farmalisto_price
      else
        if max_limit > cost
          price = (max_limit + cost) / 2.0
        else
          price = 0.01
        end
      end

      webflow_import[row + 1, 7] = price

      print cost
      print '    |    '
      print max_limit
      print '    |    '
      print (100 * (max_limit - cost) / cost).round(2)
      print '    |    '
      print price
      print '    |    '
      print ((price - cost) / cost).round(2)
      print '    |    '
      print farmalisto_price
      print '    |    '
      print farmalisto_price.class.name == 'String' ? 'NA' : (100 * (farmalisto_price - cost) / cost).round(2)
      puts


      webflow_import.save if row % save_interval == 0
      puts '--- SAVED ---'
      row += 1
    end


    puts Time.now.to_s + ' Finish Updating Google Prices'
    puts'--------------------------------------------------------------------------------'
    puts'--------------------------------------------------------------------------------'
  end
end