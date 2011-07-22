require 'spec_helper'

describe CachedForTimeController do
  render_views

  it "should expire cache" do
    obj = Modular.layout('cached_for_time')
    obj.clear_cache
    SimpleModel.should_receive(:called_by_cached_for_time).once
     
    get 'index'
    get 'index'
    
    sleep 2
    
    SimpleModel.should_receive(:called_by_cached_for_time).once
    get 'index'
  end

end
