require 'abstract_controller'
require "modular/rendering"
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
        self.name.demodulize.underscore
      end
      
      def type
        self.class.type
      end

      def self.use_mustached_template!
        require 'mustache'
        self.class_eval do
          include Modular::MstRendering
        end
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

      #params for element itself
      attr_accessor :title
      attr_accessor :uniqid
      attr_accessor :width
      
      validates :title, :length => {:maximum => 64}      
    
      def initialize(attributes = {})
        append_view_path(Rails.root.join('app', 'views'))
        append_view_path(Gem.loaded_specs['modular'].full_gem_path + '/templates')

        @attributes ||= ActiveSupport::HashWithIndifferentAccess.new
        
        @attributes[:uniqid] = ''
        @attributes[:width] = 0

        attributes.each do |name, value|
          @attributes[name.to_s] = value
        end
      end
      
      def persisted?
        false
      end

      def to_hash
        @attributes.merge({:type => type})
      end
      
      def to_json
        ActiveSupport::JSON.encode to_hash
      end

      def all_errors
        valid? #this call is used to make validation calls
        { uniqid => errors.to_a }
      end

      def find_by_uniqid(id)
        self if id.to_s == uniqid.to_s
      end
    end
  end
end