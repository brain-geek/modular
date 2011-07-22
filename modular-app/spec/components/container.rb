require 'spec_helper'

describe Modular::Components::Container, ' vertical container class ' do
  before :each do
    @cmp = described_class.new
  end
  
  it "should have container" do
    @cmp.components.should be_a_kind_of Array
  end
  
  it "should unserialize children" do
    @cmp.components.push Modular.create(:FakeNewsFeed, { :news_count => 50, :title => 'Best news feed' }).to_json
    json = @cmp.to_json
    container = Modular.from_json(json)
    container.components[0].should be_a_kind_of Modular::Components::FakeNewsFeed
  end
  
  it "should have add_container and add_child methods" do
    @cmp.add :container, :title => 'Test container title' do
      add :FakeNewsFeed, :title => 'Worst news feed'
      
      add :Vertical, :title => 'Vertical container'
    end
    
    @cmp.components[0].title.should == 'Test container title'
    
    feed = @cmp.components[0].components[0]
    feed.should be_a_kind_of Modular::Components::FakeNewsFeed
    feed.title.should == 'Worst news feed'
    
    @cmp.components[0].components[1].should be_a_kind_of Modular::Components::Vertical
  end
end
