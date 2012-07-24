module Modular::Components
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :Base
    autoload :Container
    autoload :MainContent
  end
end