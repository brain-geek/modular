Modular.configure do
  register_layout :simple do
    add Modular.create(:FakeNewsFeed, :news_count => 50, :title => 'Best news feed')
    add :main_content    
  end
  
  register_layout :nested do
    add Modular.layout(:simple)
    add :container, :width => 35 do |cont|
      add :Foobar, :text => 'Nested component'
    end
    add :MainContent
  end
  
  register_layout :cached_forever, Modular.create(:CachedForever)
  
  register_layout :cached_for_time, Modular.create(:CachedForTime)
end