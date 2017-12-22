# frozen_string_literal: true

Rails.application.routes.draw do
  resources :categories
  resources :gatekeepers
  resources :groups do
    resources :users, only: [] do
      member do
        patch :join
        delete :leave
      end
    end
  end
  resources :domains
  resources :newspapers
  resources :publishers do
    resources :groups, only: [:index] do
      member do
        patch :add
        delete :remove
      end
    end
    resources :users, only: [:index] do
      resources :privileges, only: [:index] do
        member do
          patch :permit
          delete :revoke
        end
      end
      member do
        patch :add
        delete :remove
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'listings#index'
  resources :listings
  resources :users
  match '/login/:id', to: 'users#login', as: :login, via: [:get, :post]
  match '/logout', to: 'users#logout', as: :logout, via: [:get, :post]
  get 'indexes', controller: :application, action: :indexes, as: :indexes
end
