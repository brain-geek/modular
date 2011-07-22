require 'active_model'

module Modular
  module Helpers
    class AbstractModel
      include ActiveModel::Validations
      include ActiveModel::Conversion
      extend ActiveModel::Naming
    
      def initialize(attributes = {})
        @attributes ||= ActiveSupport::HashWithIndifferentAccess.new
        
        attributes.each do |name, value|
          @attributes[name.to_s] = value
        end
      end
      
      def persisted?
        false
      end
      
      def to_json
        ActiveSupport::JSON.encode @attributes.merge({:type => type})
      end
        
      def self.attr_reader(*fields)
        fields.each do |field|
          class_eval <<EOF
        def #{field}
          @attributes['#{field}']
        end
EOF
        end
      end
        
      def self.attr_writer(*fields)
        fields.each do |field|
          class_eval <<EOF
        def #{field}=(value)
          @attributes['#{field}']=value
        end
EOF
        end
      end
      
      def self.attr_accessor(*fields)
        fields.each do |field|
          attr_writer field
          attr_reader field
        end
      end
      
      def self.attr_accessor_with_default(sym, default = Proc.new)
        define_method(sym, block_given? ? default : Proc.new { default })
        module_eval(<<-EVAL, __FILE__, __LINE__ + 1)
          def #{sym}=(value)                          # def age=(value)
            class << self; attr_accessor :#{sym} end  #   class << self; attr_accessor :age end
            @attributes['#{sym}']=value               #   @attributes['age'] = value
          end                                         # end
        EVAL
      end

      def self.attr_reader_with_default(sym, default = Proc.new)
        define_method(sym, block_given? ? default : Proc.new { default })
        module_eval(<<-EVAL, __FILE__, __LINE__ + 1)
          def #{sym}=(value)                          # def age=(value)
            class << self; attr_reader :#{sym} end    #   class << self; attr_accessor :age end
            @attributes['#{sym}']=value               #   @attributes['age'] = value
          end                                         # end
        EVAL
      end
    end
  end
end