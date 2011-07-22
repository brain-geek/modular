require 'abstract_controller'
require "modular/abstract_model"
require "modular/rendering"
require "modular/caching"

module Modular
  module Components
    class Base < Modular::Helpers::AbstractModel
      #rendering
      include AbstractController::Rendering
      include Modular::Components::DirectRender
      
      #slug
      def self.type
        self.name.rpartition("::").last
      end
      
      def type
        self.class.type
      end

      #params for element itself
      attr_reader_with_default :width, 300
      attr_reader :title
      
      validates :title, :length => {:maximum => 64}
    end
  end
end