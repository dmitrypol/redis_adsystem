Rails.application.routes.draw do

  root 'home#index'
  get 'home/index'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
