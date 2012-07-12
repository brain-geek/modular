class Foobar < Modular::Components::Base
  attr_reader :text
  
  def execute
    SimpleModel.foobar_method
  end
end
