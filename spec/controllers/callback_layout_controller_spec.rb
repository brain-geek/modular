require 'spec_helper'

describe CallbackLayoutController do
  render_views

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success

      response.body.should contain 'Nested component'
      response.body.should contain 'CallbackLayout#index'
    end
  end

end
