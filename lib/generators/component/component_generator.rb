class ComponentGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  
  def generate_template
    template "component.rb.erb", "app/components/#{filename}.rb"  
  end
  
  def generate_controller
    template "template.erb", "app/views/components/#{filename}.html.erb"  
  end
  
  private
  def filename
    name.underscore
  end
end
