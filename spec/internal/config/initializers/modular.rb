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

  register_layout :irb_nested, :irb_nested_code

  register_layout :mustached, :mustached, :text => 'Text from template settings'

  register_layout :mustache_nested, :mustache_container, :text => 'asdfgh' do
    add Modular.layout(:mustached)
    add :mustached, :text => 'Other text from template settings'
  end
end