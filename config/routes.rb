# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'listings#index'
  resources :listings
  resources :users
  post 'users/:id/login', controller: :users, action: :login, as: :login
  post 'users/logout', controller: :users, action: :logout, as: :logout
end
