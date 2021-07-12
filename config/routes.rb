Rails.application.routes.draw do
  resources :temperatures
  root 'temperatures#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
