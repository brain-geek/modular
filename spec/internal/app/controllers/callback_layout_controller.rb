class CallbackLayoutController < ApplicationController
  modular_layout :method_name
  
  def method_name
    'heavy'
  end
  
  def index
  end

end
