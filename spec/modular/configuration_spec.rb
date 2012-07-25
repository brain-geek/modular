require 'spec_helper'

describe Modular::Configuration, ' as modular config' do
  it "should register layout" do
    component = Modular.create :fake_news_feed, :news_count => 50, :title => 'Best news feed'
    
    Modular.configure do
      register_layout :testing_layout, component
    end
    
    Modular.layout(:testing_layout).should == component
  end

  it "should have DSL for registering layout" do
    Modular.configure do
      register_layout :testing_layout do
        add :fake_news_feed, :title => 'Best news feed'
        add :fake_news_feed, :title => 'Just news feed'
        
        add :container do
          add :fake_news_feed, :title => 'Worst news feed'
        end
      end
    end
    
    l = Modular.layout(:testing_layout)
    
    l.should be_a_kind_of Modular::Components::Container
    
    l.components[0..1].each do |e|
      e.should be_a_kind_of FakeNewsFeed
    end

    l.components.length.should == 3
  end

  it "should return list of layouts" do
    Modular.configure do
      register_layout :simple_existing, :container do |layout|
      end
    end
    
    Modular.layouts.should be_a_kind_of Hash
    Modular.layouts.keys.should include 'simple_existing'
  end  
end
