require 'spec_helper'

describe Modular, ' widgets creation ' do
  it "should fail creating non-existant class" do
    lambda { Modular.create(:fdgasdasdfasdfasdfasdf) }.should raise_error
  end

  it "should create existant class" do
    cmp = Modular.create(:fake_news_feed)
    cmp.should be_a_kind_of FakeNewsFeed
  end
  
  it "should create class from global namespace" do
    cmp = Modular.create(:foobar)
    cmp.should be_a_kind_of Modular::Components::Base
    cmp.should be_a_kind_of Foobar
  end

  it "should return back already created widget" do
    widget = Modular.create(:foobar)

    Modular.create(widget).should eq(widget)
  end
  
  it "should unserialize components correctly" do
    serialized = Modular.create(:fake_news_feed, :news_count => 50, :title => 'Best news feed').to_json

    cmp_uns = Modular.from_json(serialized)
    cmp_uns.news_count.to_i.should === 50
    cmp_uns.title.should === 'Best news feed'
  end
end