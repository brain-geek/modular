require 'spec_helper'

describe Modular::Components::Base, ' as basic module' do
  it "should return type in class" do
    Modular::Components::Base.type.should === 'Base'
  end
  
  it "should return type in instance" do
    Modular::Components::Base.new.type.should === 'Base'
  end

  it "should serialize components correctly" do
    cmp = Modular.create :FakeNewsFeed, :news_count => 50,  :title => 'Best news feed'
    serialized = cmp.to_json
  end
  
  it "should create component with hash as params" do
    feed = Modular.create(:FakeNewsFeed, { :news_count => 500, :title => 'Simple news feed' })
    feed.news_count.should === 500
    feed.title.should == 'Simple news feed'
  end
  
  it "should not try to create element if it is already present" do
    a = Modular.create(:FakeNewsFeed, { :news_count => 500, :title => 'Simple news feed' })
    a.should == Modular.create(a)
  end

  it "should render block" do
    feed = Modular.create(:FakeNewsFeed, { :news_count => 3, :title => 'Simple news feed' })
    a = feed.render
    a.should == '<h1>Template - Simple news feed</h1>'
  end
end