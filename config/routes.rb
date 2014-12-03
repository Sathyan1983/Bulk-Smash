Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show] do
    member do
      get 'request', to: 'friendships#send_request'
      get 'accept', to: 'friendships#accept_request'
      get 'remove_friendship', to: 'friendships#destroy'
    end
    resources :lists, only: [:show, :edit, :destroy]
  end

  resources :lists, only: [:new, :create]

  resources :list_items, only: [:destroy]
  resources :foods
  resources :units

  root 'static_pages#home'
end
