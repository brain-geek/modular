module Modular::Rendering
  extend ActiveSupport::Concern
  
  def controller_path
    'components'
  end
  
  def action_name
    type.underscore
  end

  # def config
  #   ActionController::Base.config
  # end
  
  def execute
  end
  
  def render
    execute
    modular_render :render_type => :indirect
  end

  # we are not in a browser, no need for this
  def protect_against_forgery?
    false
  end
  
  # so that your flash calls still work
  def flash
    {}
  end

  def params
    {}
  end
  protected 
  def modular_render(args = {})
    render_to_string :file => 'components/' + action_name, :locals => args
  end
  
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