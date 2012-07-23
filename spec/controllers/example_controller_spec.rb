require 'spec_helper'

describe ExampleController do

  describe "GET 'index'" do
    render_views

    it "should be successful" do
      get 'index'
      # binding.pry
      response.body.should contain 'Template - Best news feed'
      response.body.should contain 'Find me in app/views/example/index.html.erb'
    end
  end

end
