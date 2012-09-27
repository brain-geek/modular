require 'spec_helper'

describe Modular, ' finders ' do
  describe "simple objects" do
    let(:element) { Modular.create(:fake_news_feed, :news_count => 50, :title => 'Best news feed', :uniqid => 'asdf') }

    it "finds itself" do
      element.find_by_uniqid('asdf').should be element
    end

    it "does not find itself if id is wrong" do
      element.find_by_uniqid('qwe').should be_nil
    end
  end

  describe "containers" do
    let(:element) { Modular.create(:container, :uniqid => 'asdf') }

    it "finds itself" do
      element.find_by_uniqid('asdf').should be element
    end

    it "finds itself as symbol" do
      element.find_by_uniqid(:asdf).should be element
    end

    it "does not find itself if id is wrong" do
      element.find_by_uniqid('qwe').should be_nil
    end

    it "finds children in containers" do
      element.children.push(child = Modular.create(:fake_news_feed, :uniqid => 'gfsd'))
      element.find_by_uniqid('gfsd').should be child
    end

    it "finds children in children containers" do
      element.children.push(child_cont = Modular.create(:container))
      child_cont.children.push(child = Modular.create(:fake_news_feed, :uniqid => 'gfsd'))

      element.find_by_uniqid('gfsd').should be child
    end

    it "does not find if nothing to be found" do
      element.children.push(child = Modular.create(:fake_news_feed, :uniqid => '1'))      

      element.children.push(child_cont = Modular.create(:container))
      child_cont.children.push(child = Modular.create(:fake_news_feed, :uniqid => '2'))

      element.find_by_uniqid('3').should be_nil
    end
  end
end