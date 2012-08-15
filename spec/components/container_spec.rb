require 'spec_helper'

describe Modular::Components::Container, ' vertical container class ' do
  before :each do
    @cmp = described_class.new
  end
  
  it "should have children" do
    @cmp.children.should be_a_kind_of Array
  end

  it "should not fail if nil passed to add" do
    @cmp.add nil
    @cmp.children.should be_empty
  end
  
  it "should have add_container and add_child methods" do
    @cmp.add :container, :title => 'Test container title' do
      add :FakeNewsFeed, :title => 'Worst news feed'
      
      add :Vertical, :title => 'Vertical container'
    end
    
    @cmp.children[0].title.should == 'Test container title'
    
    feed = @cmp.children[0].children[0]
    feed.should be_a_kind_of FakeNewsFeed
    feed.title.should == 'Worst news feed'
    
    @cmp.children[0].children[1].should be_a_kind_of Vertical
  end
end
