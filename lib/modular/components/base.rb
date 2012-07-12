require 'abstract_controller'
require "modular/rendering"
require "modular/caching"

module Modular
  module Components
    class Base < Modular::Helpers::AbstractModel
      #rendering
      include AbstractController::Rendering
      include AbstractController::Helpers
      include Modular::Rendering

      def self.abstract?
        true
      end

      #slug
      def self.type
        self.name.rpartition("::").last
      end
      
      def type
        self.class.type
      end

      #params for element itself
      attr_accessor :title
      
      validates :title, :length => {:maximum => 64}      
    end
  end
end