class Modular::Components::CachedForTime < Modular::Components::Base
  include Modular::Components::Caching
  cache :expires_in => 2.seconds
  
  def execute
    SimpleModel.called_by_cached_for_time
  end
end

CachedForTime = Modular::Components::CachedForTime 