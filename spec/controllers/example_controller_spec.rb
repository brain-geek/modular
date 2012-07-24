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
    it "should be successful" do
      get 'mustache'
      response.should be_success      
      
      response.body.should contain 'Text in layout'
      response.body.should contain 'Text from mustache template - Text from template settings'
    end
  end
end
