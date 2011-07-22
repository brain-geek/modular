require 'spec_helper'

describe Modular::Configuration, ' as modular config' do

  it "should use defaults from config" do
    Modular.configure
    
    Modular.config.columns.should_not be nil
    Modular.config.column_width.should_not be nil
    Modular.config.padding_width.should_not be nil
  end

  it "should be configurable by lambda" do
    Modular.configure do |c|
      c.columns = 99
      c.column_width = 999
      c.padding_width = 9999
    end
    
    Modular.config.columns.should === 99
    Modular.config.column_width.should === 999
    Modular.config.padding_width.should === 9999
  end

  it "should export configuration as json" do
    Modular.configure do |c|
      c.columns = 12
      c.column_width = 100
      c.padding_width = 10
      
    end
    
    lambda { Modular.config.to_json }.should_not raise_error
    
    target = ActiveSupport::JSON::decode(Modular.config.to_json).with_indifferent_access
    
    target[:columns].should === 12
    target[:column_width].should === 100
    target[:padding_width].should === 10
  end
  
  it "should register layout" do
    component = Modular.create :FakeNewsFeed, :news_count => 50, :title => 'Best news feed'
    
    Modular.configure do
      register_layout :simple, component
    end
    
    Modular.layout(:simple).to_json == component
  end

  it "should have DSL for registering layout" do
    Modular.configure do
      register_layout :simple, :Container do
        add :FakeNewsFeed, :title => 'Best news feed'
        add :FakeNewsFeed, :title => 'Just news feed'
        
        add :container do
          add :FakeNewsFeed, :title => 'Worst news feed'
        end
      end
    end
    
    l = Modular.layout(:simple)
    
    l.should be_a_kind_of Modular::Components::Container
    
    l.components[0..1].each do |e|
      e.should be_a_kind_of Modular::Components::FakeNewsFeed
    end
    l.components.length.should == 3
  end
  
end
