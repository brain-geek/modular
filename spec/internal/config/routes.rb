Rails.application.routes.draw do
  root :to => "example#index"
  
  match ':controller/(:action)'
end
