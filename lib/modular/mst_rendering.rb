module Modular
  class Template < ::Mustache
  end

  module MstRendering
    def render
      Template.template_path = Rails.root + "app/views/components"
      Template.template_extension = 'mst'
      Template.render_file("./#{type}", @attributes).html_safe
    end
  end
end