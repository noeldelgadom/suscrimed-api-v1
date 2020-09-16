module WebflowTool
  # require 'nokogiri'

  require_relative '../rest_tool.rb'

  # reload! ; load "lib/webflow/webflow_module.rb" ; include WebflowTool ; WebflowTool.retrieve_cms

  def self.retrieve_cms
    url   = 'https://jsonplaceholder.typicode.com/posts'
    data  = RestTool.retrieve_data(url)
  end
end
