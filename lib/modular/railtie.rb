require 'modular/action_controller_extension'

module TaggableCache
  class Railtie < ::Rails::Railtie
    initializer "modular" do |app|
      ActiveSupport.on_load(:action_controller) do
        ::ActionController::Base.__send__ :include, Modular::ActionControllerExtension
      end
    end

    generators do
      require "modular/generators/component/component_generator"
    end    
  end  
end
