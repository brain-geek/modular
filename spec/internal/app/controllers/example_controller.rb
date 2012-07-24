class ExampleController < ApplicationController
  def index
    modular_layout 'simple'
  end

  def mustache
    modular_layout 'mustached'
  end
end
