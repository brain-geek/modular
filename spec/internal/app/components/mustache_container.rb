class MustacheContainer < Modular::Components::Container
  attr_accessor :text

  use_mustached_template!
end
