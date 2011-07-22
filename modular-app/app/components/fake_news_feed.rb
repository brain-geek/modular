module Modular
  module Components
    class FakeNewsFeed < Modular::Components::Base
      attr_reader :news_count
    end
  end
end

FakeNewsFeed = Modular::Components::FakeNewsFeed
