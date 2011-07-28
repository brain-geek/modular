require 'spec_helper'

describe Modular::Components::HelloWorld, ' vertical container class ' do
  it "should have container" do
    cmp = Modular.create :hello_world
    cmp.render.should == 'Hello, world!' 
  end
end
