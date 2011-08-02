require 'erb'

module Modular
  class LayoutGenerator
    class ERBContext
      def initialize(hash)
        hash.each_pair do |key, value|
          instance_variable_set('@' + key.to_s, value)
        end
      end
    
      def get_binding
        binding
      end
    end
    
    def self.generate(id, params = {})
      new(id, params).generate
    end
    
    def generate
      write_layout unless layout_exists?
      filename.to_s
    end

    def initialize(id, params)
      @id = id
      @params = params
    end

    protected
    def foldername
      'tmp/modular/'
    end
      
    def filename
      foldername + (@id.to_s + (@params[:cache_key].to_s) + '.html.erb')
    end
    
    def layout_exists?
      if (defined? Rails) && (Rails.configuration.action_controller.perform_caching)
        File.exists?(filename)
      else
        false
      end
    end
    
    def write_layout
      folder = self.foldername
      filename = self.filename
      
      Dir.mkdir(folder) unless File.exists? folder
      
      template = ERB.new File.new(Gem.loaded_specs['modular'].full_gem_path + '/templates/layout.erb').read
      output = template.result(ERBContext.new(template_variables).get_binding)
      
      File.open(filename, 'w') do |f| 
        f.write(output)
      end
    end
    
    def template_variables
      { :original_layout => 'application' }.merge(@params.merge(:layout_id => @id))
    end
  end
end
