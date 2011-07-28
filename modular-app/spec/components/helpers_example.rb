require 'spec_helper'

describe Modular::Components::HelpersExample, ' example for using helpers' do
  it "should not fail" do
    cmp = Modular.create :helpers_example
    cmp.render 
  end
end
