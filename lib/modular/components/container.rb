module Modular
  module Components
    class Container < Base
      attr_accessor :components
      
      def initialize(attributes = {})
        @attributes = ActiveSupport::HashWithIndifferentAccess.new(:components => [])
        attributes = attributes.with_indifferent_access
        attributes["components"] ||= []

        attributes["components"].each do |value|
          if value.is_a? Modular::Components::Base
            @attributes[:components].push value
          else
            @attributes[:components].push(Modular.from_json(value)) rescue ''
          end
        end
        
        super(attributes.except("components"))
      end
      
      def add(type, args = {}, &block)
        cont = Modular.create(type, args)
        cont.instance_eval &block if block_given?
        components.push cont
      end

    end
  end
end