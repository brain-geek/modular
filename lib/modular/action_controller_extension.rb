module Modular::ActionControllerExtension
  extend ActiveSupport::Concern

  def modular_layout(name)
    render :layout => get_layout_path(name)
  end

  def get_layout_path(name)
    if name.is_a?(Symbol) 
      
      name = self.__send__(name)
    end

    path = '../../../' + Modular.generate_rails_layout(name)
    #cutting off '.html.erb'
    path[0, path.length-9]
  end

  module ClassMethods
    def modular_layout(name)
      proc = Proc.new do |controller|
        
        controller.send(:get_layout_path, name)
      end
      
      layout proc
    end
  end
end