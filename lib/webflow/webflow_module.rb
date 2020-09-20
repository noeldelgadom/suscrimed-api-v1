module WebflowTool
  require 'rest-client'
  require 'json'

  # reload! ; load "lib/webflow/webflow_module.rb" ; include WebflowTool ; WebflowTool.get_info

  def self.get_info
    url       = 'https://api.webflow.com/info'
    response  = RestClient.get url, {
      'Authorization' => 'Bearer Actual-Token',
      'accept-version' => '1.0.0'
    }
    JSON.parse(response.body)
  end
end