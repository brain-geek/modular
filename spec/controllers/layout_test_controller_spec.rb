require 'spec_helper'

describe LayoutTestController do
  render_views

  describe "requirements" do
    it "should render itself" do
      Modular.layout(:nested).render
    end
  end
  
  describe "rendering" do
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

  it "should not call render twice" do
    File.unlink("#{Rails.root}/tmp/modular/nested.html.erb") rescue

    Rails.configuration.action_controller.perform_caching = true

    SimpleModel.should_receive(:foobar_method).twice

    get 'index'

    Rails.configuration.action_controller.perform_caching = true

    get 'index'
    get 'index'

    File.unlink("#{Rails.root}/tmp/modular/nested.html.erb") rescue

    get 'index'

    get 'index'
    get 'index'    
  end
end
