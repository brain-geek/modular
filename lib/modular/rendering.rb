module Modular::Rendering
  extend ActiveSupport::Concern
  
  def action_name
    type.underscore
  end
  
  def execute
  end

  def render(args = {})
    execute
    render_to_string :file => 'components/' + action_name, :locals => args
  end

  protected 
 
  module ClassMethods
    def view_context_class
      context = super
      
      context.send :define_method, :render_component do |component|
        component.render
      end
      
      context.send :include, Rails.application.routes.url_helpers if defined? Rails
      
      context.send :include, ApplicationHelper if defined? ApplicationHelper
      
      context
    end
  end
end