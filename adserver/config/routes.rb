Rails.application.routes.draw do

  root 'ad#index'
  resources :click, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
