require 'rails'

module Modular
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :Creation
    autoload :Configuration
    autoload :Components
    autoload :LayoutGenerator
  end

  delegate :create, :from_json, :to => Creation
  delegate :config, :configure, :to => Configuration
  
  def layout(id)
    if Configuration.config.layouts.has_key?(id)
      Configuration.config.layouts[id]
    else
      raise "Layout '#{id}' not found"
    end
  end

  def layouts
    Configuration.config.layouts
  end
  
  def generate_rails_layout(id, params = {})
    LayoutGenerator.generate(id, params)
  end
  
  extend self
end

require "modular/version"
require 'modular/railtie'