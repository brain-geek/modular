class SimpleModel < ActiveRecord::Base
  
  class << self
    def called_by_cached_forever
    end
  
    def called_by_cached_for_time
    end
    
    def foobar_method
    end
  end

end
