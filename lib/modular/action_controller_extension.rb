module Modular::ActionControllerExtension
  extend ActiveSupport::Concern

  def modular_layout(name)
    layout = Modular.layout name
    render :text => layout.render
  end

  module ClassMethods
    def modular_layout(name, params = {})
      proc = Proc.new do |controller|
        path = '../../../' + Modular.generate_rails_layout(name.is_a?(Symbol) ? controller.__send__(name) : name, params)
        #cutting off '.html.erb'
        path[0, path.length-9]
      end
      
      layout proc
    end
  end
end