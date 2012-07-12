module Modular
  module Creation
    def create(typ, params = {})
      return typ if typ.is_a? Modular::Components::Base
      
      begin
        begin
          component = typ.to_s.camelize.constantize.new params
        rescue NameError
          component = (Components.name + '::' + typ.to_s.camelize).constantize.new params
        end
      rescue Exception => e
        raise "Unable to create element " + typ.to_s
      end

      raise "Component has errors: " + component.errors.to_s if component.invalid?
      
      component
    end
    
    def from_json(text)
      obj = ActiveSupport::JSON.decode text
      raise "Type expected in json string" unless obj['type']
      create(obj['type'], obj.except('type'))
    end    

    extend self
  end
end
