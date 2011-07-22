require 'spec_helper'

describe ExampleController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.body.should contain 'Template - Best news feed'
    end
  end

end
