Rails.application.routes.draw do
  get 'profile/show'
  get 'stimulus/popup'
  devise_for :users
  root to: "matches#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  resources :profiles, only: [:show]
  resources :matches do
    resources :requests, only: [:new, :create, :update]
  end
  resources :requests, only: [:index, :show, :destroy]
  get "games", to: "requests#games"

  patch 'accept_requests/:id', to: 'requests#accepted?', as: 'accept_request'
  patch 'refuse_requests/:id', to: 'requests#refused?', as: 'refuse_request'

end
