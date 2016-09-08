Rails.application.routes.draw do

  root 'ad#index'
  get 'click', to: 'click#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
