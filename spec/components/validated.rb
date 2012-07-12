require 'spec_helper'

describe Modular::Components::Validated, ' as non-generatable component ' do
  it "should throw error if generated" do
    lambda {
      Modular.create(:Container).add_container :title => 'Test container title' do |cont2|
        add_child(:Validated)
      end
    }.should raise_error
    
    lambda {
      Modular.create(:Validated)
    }.should raise_error
  end
end
