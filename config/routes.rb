Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorite/create'
  devise_for :users
  root to: 'pages#home'
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
  resources :pets do
    resources :favorites, only: [:new, :create]
    resources :requests, only: [:new, :create]
    get :index_breeder, on: :collection
  end
  get "requests/requested", to: "requests#requested"
  resources :requests, only: [:index, :edit, :destroy] do
    post :confirm, :refuse,  on: :member
  end

  resources :favorites, only: [:index, :destroy]
  resources :messengers, only: :show do
    resources :messages, only: :create
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
