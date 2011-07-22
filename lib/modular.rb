require "active_support/all"

module Modular
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :Configuration
    autoload :LayoutGenerator
  end
  
  def create(typ, params = {})
    return typ if typ.is_a? Components::Base
    
    begin
      begin
        component = typ.to_s.camelize.constantize.new params
      rescue NameError
        component = (Components.name + '::' + typ.to_s.camelize).constantize.new params
      end
    rescue Exception => e
      raise "Unable to create element " + typ.to_s
    end
    
    raise "Component has errors: " + component.errors.to_s unless component.valid?
    
    component
  end
  
  def from_json(text)
    obj = ActiveSupport::JSON.decode text
    raise "Type expected in json string" unless obj['type']
    create(obj['type'], obj.except('type'))
  end
  
  delegate :config, :configure, :to => Configuration
  
  def layout(id)
    Configuration.config.layouts[id]
  end
  
  def layouts
    Configuration.config.layouts.keys
  end
  
  def generate_rails_layout(id, params = {})
    LayoutGenerator.generate(id, params)
  end
  
  extend self
end

require "modular/components/base"
require "modular/components/container"
require "modular/components/main_content"
require "modular/version"

require "modular/rails" if defined? Rails