module Modular
  module Creation
    def create(typ, params = {})
      return typ if typ.is_a? Modular::Components::Base
      
      begin
        component = typ.to_s.camelize.constantize.new params
      rescue NameError
        component = (Components.name + '::' + typ.to_s.camelize).constantize.new params
      end
      
      component
    end
    
    def from_json(obj)
      obj = ActiveSupport::JSON.decode obj if obj.is_a? String
      obj = obj.with_indifferent_access
      
      raise "Type expected in json string" unless obj['type']
      component = create(obj['type'], obj.except('type').except("children"))

      if obj.has_key?('children') && component.is_a?(Modular::Components::Container)
        obj['children'].each do |child|
          if child.is_a? Hash
            child_component = from_json(child)
            component.add(child_component)
          end
        end
      end

      component
    end

    extend self
  end
end
