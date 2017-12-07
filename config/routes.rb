# frozen_string_literal: true

Rails.application.routes.draw do
  resources :groups
  resources :domains
  resources :newspapers
  resources :publishers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'listings#index'
  resources :listings
  resources :users
  post 'users/:id/login', controller: :users, action: :login, as: :login
  match '/logout', to: 'users#logout', as: :logout, via: [:get, :post]
end
