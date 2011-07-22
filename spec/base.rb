require 'spec_helper'

describe Modular, ' as modular ' do
  it "should fail creating non-existant class" do
    lambda { Modular.create(:fdgasdasdfasdfasdfasdf) }.should raise_error
  end

  it "should create existant class" do
    cmp = Modular.create(:FakeNewsFeed)
    cmp.should be_a_kind_of Modular::Components::FakeNewsFeed
  end
  
  it "should create class from global namespace" do
    cmp = Modular.create(:Foobar)
    cmp.should be_a_kind_of Modular::Components::Base
    cmp.should be_a_kind_of Foobar
  end
  
  it "should unserialize components correctly" do
    serialized = Modular.create(:FakeNewsFeed, :news_count => 50, :title => 'Best news feed').to_json

    cmp_uns = Modular.from_json(serialized)
    cmp_uns.news_count.to_i.should === 50
    cmp_uns.title.should === 'Best news feed'
  end
  
  it "should return list of layouts" do
    Modular.configure do
      register_layout :simple_existing, :Container do |layout|
      end
    end
    
    Modular.layouts.should be_a_kind_of Array
    Modular.layouts.should include 'simple_existing'
  end
  
end