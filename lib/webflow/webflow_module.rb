module WebflowTool
  require 'rest-client'
  require 'json'

  # reload! ; load "lib/webflow/webflow_module.rb" ; include WebflowTool ; WebflowTool.get_info

  def self.get_info
    url           = 'https://api.webflow.com/info'
    webflow_auth  = JSON.parse(File.read('config/api-keys/webflow-auth.json'))

    response        = RestClient.get url, {
      'Authorization' => 'Bearer ' + webflow_auth['api_token'],
      'accept-version' => '1.0.0'
    }
    JSON.parse(response.body)
  end
end