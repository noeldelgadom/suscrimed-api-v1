module RestTool
  require 'rest-client'
  require 'json'

  # reload! ; load "lib/rest_tool.rb" ; include RestTool ; RestTool.retrieve_data

  def self.retrieve_data(url)
    response  = RestClient.get URI::encode(url)
    JSON.parse(response.body)
  end
end