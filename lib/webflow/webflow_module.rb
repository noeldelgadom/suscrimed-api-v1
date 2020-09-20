module WebflowTool
  require 'rest-client'
  require 'json'

  # reload! ; load "lib/webflow/webflow_module.rb" ; include WebflowTool ; WebflowTool.get_info

  def self.get_info
    url = 'https://api.webflow.com/info'
    WebflowTool.get(url)
  end

  # reload! ; load "lib/webflow/webflow_module.rb" ; include WebflowTool ; WebflowTool.get_products

  def self.get_products
    url = 'https://api.webflow.com/sites/' + JSON.parse(File.read('config/api-keys/webflow-auth.json'))['site'] + '/products'
    WebflowTool.get(url)
  end

  def self.get(url)
    response  = RestClient.get url, WebflowTool.headers
    JSON.parse(response.body)
  end

  def self.headers
    {
      'accept-version'  => '1.0.0',
      'Authorization'   => 'Bearer ' + JSON.parse(File.read('config/api-keys/webflow-auth.json'))['api_token']
    }
  end
end