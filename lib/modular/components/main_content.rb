class Modular::Components::MainContent < Modular::Components::Base
  def render(args = {})
    '<%=yield%>'.html_safe
  end
end

MainContent = Modular::Components::MainContent 