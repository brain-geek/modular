require 'action_controller'

class ActionController::Base
  def render_modular_layout(name)
    layout = Modular.layout name
    render :text => layout.render
  end

  def self.modular_layout(name, params = {})
    proc = Proc.new do |controller|
      '../../../' + Modular.generate_rails_layout(name.is_a?(Symbol) ? controller.__send__(name) : name, params)
    end
    
    layout proc
  end
end
