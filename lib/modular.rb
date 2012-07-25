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
  delegate :layout, :layouts, :to => :config
  
  def generate_rails_layout(id, params = {})
    LayoutGenerator.generate(id, params)
  end
  
  extend self
end

require "modular/version"
require 'modular/railtie'