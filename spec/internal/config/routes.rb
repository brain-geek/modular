Rails.application.routes.draw do
  get "cached_for_time/index"

  root :to => "example#index"
  
  match ':controller/(:action)'
end
