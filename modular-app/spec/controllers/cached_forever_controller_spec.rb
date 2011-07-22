require 'spec_helper'

describe CachedForeverController do
  render_views
  
  it "should do caching" do
    Modular.layout('cached_forever').clear_cache
    SimpleModel.should_receive(:called_by_cached_forever).once
     
    get 'index'
    
    Modular.layout('cached_forever').should_receive(:cached?).and_return(true)
    Modular.layout('cached_forever').should_receive(:get_cached)
    
    get 'index'
  end
end
