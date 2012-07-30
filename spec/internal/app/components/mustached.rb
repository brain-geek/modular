class Mustached < Modular::Components::Base
  attr_accessor :text

  use_mustached_template!
end
