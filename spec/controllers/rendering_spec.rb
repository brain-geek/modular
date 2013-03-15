require 'spec_helper'

describe ExampleController do
  render_views

  describe "straightforward rendering" do
    it "should be successful" do
      get 'index'
      
      response.body.should contain 'Template - Best news feed'
      response.body.should contain 'Find me in app/views/example/index.html.erb'
    end
  end

  describe "mustache rendering" do
    it "simple" do
      get 'mustache'
      response.should be_success      
      
      response.body.should contain 'Text in layout'
      response.body.should contain 'Text from mustache template - Text from template settings'
    end

    it "nested" do
      get 'mustache_nested'
      response.should be_success      
      
      response.body.should contain 'Text from container settings - asdfgh'
      response.body.should contain 'Text from mustache template - Text from template settings'
      response.body.should contain 'Text from mustache template - Other text from template settings'      
    end
  end

  describe "irb nested rendering" do
    it "should render nested IRB data" do
      get 'irb_nested'

      response.body.should contain 'Symbol'
      response.body.should contain 'hello_world_symbol'
    end
  end
end
