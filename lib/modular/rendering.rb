module Modular
  module Components
    module DirectRender
      extend ActiveSupport::Concern
      
      module InstanceMethods
  
        def controller_path
          'components'
        end
        
        def action_name
          type.underscore
        end
        
        def config
          ActionController::Base.config
        end
        
        def execute
          
        end
        
        def render
          execute
          modular_render :render_type => :direct
        end
        
        def initialize(attributes = {})
          append_view_path File.join('app', 'views')
          super
        end
        
        protected 
        def modular_render(args = {})
          render_to_string :file => 'components/' + action_name, :locals => args
        end
      end
      
      
      module ClassMethods
        def view_context_class
          context = super
          
          context.send :define_method, :render_component do |component|
            if component.is_a?(Modular::Components::IndirectRender)
              component.indirect_render
            else
               a = "<%= Modular.from_json('"+ component.to_json + "').render %>"
               a.html_safe
            end
          end
          
          context.send :include, Rails.application.routes.url_helpers if defined? Rails
          
          context.send :include, ApplicationHelper if defined? ApplicationHelper
          
          context
        end
      end

    end

    module IndirectRender
      def execute
      end
      
      def indirect_render
        execute
        modular_render :render_type => :indirect
      end

      def render(args = {})
        throw "Direct render unavailible for this component"
      end
      
      def self.included(base)
        thow "Unable to use indirect render without direct render" unless base.ancestors.include? Modular::Components::DirectRender
      end
    end
  end
end