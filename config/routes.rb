Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show] do
    member do
      get 'request', to: 'friendships#send_request'
      get 'accept', to: 'friendships#accept_request'
    end
  end

  root 'static_pages#home'
end
