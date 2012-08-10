module Modular
  module Components
    class Container < Base
      attr_accessor :children
      
      def initialize(attributes = {})
        @attributes = ActiveSupport::HashWithIndifferentAccess.new(:children => [])
        attributes = attributes.with_indifferent_access
        attributes["children"] ||= []

        attributes["children"].each do |value|
          @attributes[:children].push value if value.is_a? Modular::Components::Base
        end
        
        super(attributes.except("children"))
      end
      
      def add(type, args = {}, &block)
        cont = Modular.create(type, args)
        cont.instance_eval &block if block_given?
        children.push cont
      end

      def valid?(context = nil)
        children.each do |child|
          return false if child.invalid?
        end

        super
      end

      def all_errors
        errs = super

        children.each do |child|
          e = child.all_errors
          e.each do |key, value|
            unless value.empty?
              errs[key] ||= []
              errs[key] += value
            end
          end
        end

        errs
      end      
    end
  end
end