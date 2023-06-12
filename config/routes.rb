Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
  resources :pets do
    resources :requests, only: [:new, :create]
  end
  get "requests/requested", to: "requests#requested"
  resources :requests, only: [:index, :edit, :destroy] do
    post :confirm, :refuse,  on: :member
  end

  resources :messengers, only: :show
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
