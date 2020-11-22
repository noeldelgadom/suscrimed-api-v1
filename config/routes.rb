Rails.application.routes.draw do
  resources :tax_types
  resources :ieps_types
  resources :iva_types
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
