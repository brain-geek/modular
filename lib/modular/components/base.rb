require 'abstract_controller'
require "modular/rendering"
require "modular/caching"
require 'active_model'

module Modular
  module Components
    class Base < AbstractController::Base
      #rendering
      include AbstractController::Rendering
      include AbstractController::Helpers
      include Modular::Rendering

      abstract!

      #slug
      def self.type
        self.name.rpartition("::").last
      end
      
      def type
        self.class.type
      end

      include ActiveModel::Validations
      include ActiveModel::Conversion
      extend ActiveModel::Naming

        
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


      #params for element itself
      attr_accessor :title
      
      validates :title, :length => {:maximum => 64}      
    
      def initialize(attributes = {})
        append_view_path(Rails.root.join('app', 'views'))
        append_view_path(Gem.loaded_specs['modular'].full_gem_path + '/templates')

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
    end
  end
end