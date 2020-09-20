module WebflowTool
  require 'rest-client'
  require 'json'

  # reload! ; load "lib/webflow/webflow_module.rb" ; include WebflowTool ; WebflowTool.get_info

  def self.get_info
    url           = 'https://api.webflow.com/info'

    response        = RestClient.get url, WebflowTool.headers
    JSON.parse(response.body)
  end

  def self.headers
    webflow_auth  = JSON.parse(File.read('config/api-keys/webflow-auth.json'))
    {
      'accept-version' => '1.0.0',
      'Authorization' => 'Bearer ' + webflow_auth['api_token']
    }
  end
end