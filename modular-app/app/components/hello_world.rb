class Modular::Components::HelloWorld < Modular::Components::Base
  def execute
    @text = 'Hello, world!'
  end
end

HelloWorld = Modular::Components::HelloWorld 