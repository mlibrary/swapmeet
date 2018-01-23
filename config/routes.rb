# frozen_string_literal: true

Rails.application.routes.draw do
  resources :newspapers
  root to: 'listings#index'
  resources :listings
  resources :users
  match '/login/:id', to: 'users#login', as: :login, via: [:get, :post]
  match '/logout', to: 'users#logout', as: :logout, via: [:get, :post]
  get 'indexes', controller: :application, action: :indexes, as: :indexes
end
