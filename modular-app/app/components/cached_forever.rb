class Modular::Components::CachedForever < Modular::Components::Base
  include Modular::Components::Caching
  cache
  
  def execute
    SimpleModel.called_by_cached_forever
  end
end

CachedForever = Modular::Components::CachedForever 