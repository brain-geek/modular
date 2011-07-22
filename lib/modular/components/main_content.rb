class Modular::Components::MainContent < Modular::Components::Base
  include Modular::Components::IndirectRender
  
  def indirect_render(args = {})
    '<%=yield%>'.html_safe
  end
end

MainContent = Modular::Components::MainContent 