module Modular
  class Configuration
    attr_accessor_with_default :columns, 12
    attr_accessor_with_default :column_width, 68
    attr_accessor_with_default :padding_width, 15
    attr_reader :layouts
    
    def self.config
      @@config ||= new
    end
  
    def self.configure(&block)
      @@config = new
      @@config.instance_eval &block if block_given?
      @@config
    end
    
    def register_layout(layout, mod = :Container, params = {}, &block)
      @layouts ||= {}.with_indifferent_access
      
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