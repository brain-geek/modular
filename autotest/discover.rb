Autotest.add_discovery { "rspec2" }

Autotest.add_hook :initialize do |at|
  at.add_mapping(%r%^spec/.*\.rb$%) { |filename, _|
    
    filename
  }
  
  %w{.git .svn .hg .DS_Store ._* spec/helpers spec/testdata}.each do |exception|
    at.add_exception(exception)
  end
end