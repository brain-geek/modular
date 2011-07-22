require 'spec_helper'

describe LayoutTestController do
  describe "prerequirements" do
    it "should render itself" do
      Modular.layout(:nested).indirect_render
    end
  end
  
  describe "GET 'index'" do
    render_views
    
    before :each do
      get 'index'
    end
    
    it "should have text from controller" do
      response.body.should contain 'Some text in controller template'
    end
    
    it "should have text from layout" do
      response.body.should contain 'Some Text in layout'
    end

    it "should have text from modular layout" do
      response.body.should contain 'Template - Best news feed'
    end
    
    it "should have text from nested modular layout component" do
      response.body.should contain 'Nested component'
    end
    
    it "should not be cached" do
      get 'index'
    end
    
  end
end
