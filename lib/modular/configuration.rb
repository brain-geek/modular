require 'singleton'

module Modular
  class Configuration
    include ::Singleton

    attr_reader :layouts
    
    def self.config
      self.instance
    end
  
    def self.configure(&block)
      instance = self.instance
      instance.instance_eval &block if block_given?
      instance
    end
    
    def register_layout(layout, mod = :container, params = {}, &block)
      @layouts ||= Hash.new.with_indifferent_access
      
      if mod.is_a? Components::Base
        @layouts[layout.to_s] = mod
      else
        root_layout = Modular.create mod, params
        root_layout.instance_eval &block if block_given?
        @layouts[layout.to_s] = root_layout
      end
    end
  end
end