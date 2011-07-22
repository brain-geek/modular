require 'spec_helper'

describe IndirectRenderController do
  describe 'GET /index' do
    render_views
    
    it "should be successful" do
      get 'index'
      get 'index'
      #Modular.layout(:heavy).components[1].called.should == 1
    end
  end
end
