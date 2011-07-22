class Modular::Components::Validated < Modular::Components::Base
  attr_reader :non_existant_property
  
  validates_presence_of :non_existant_property
  
  def execute
  end
end

Validated = Modular::Components::Validated