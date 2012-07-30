module Modular
  module MstRendering
    def render
      path = Rails.root + "app/views/components/#{type}.mst"
      template = File.open(path, "rb").read

      Mustache.render(template, @attributes).html_safe
    end
  end
end