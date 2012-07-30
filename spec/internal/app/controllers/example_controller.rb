class ExampleController < ApplicationController
  def index
    modular_layout 'simple'
  end

  def mustache
    modular_layout 'mustached'
  end

  def mustache_nested
    modular_layout 'mustache_nested'
  end
end
