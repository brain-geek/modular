class CallbackLayoutController < ApplicationController
  modular_layout :callback_method
  
  def index
  end

protected
  def callback_method
    'nested'
  end
end
