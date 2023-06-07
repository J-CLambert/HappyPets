Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "pages/dashboard", to: "pages#dashboard"
  resources :pets do
    resources :requests, only: [:new, :create]
    post :search, on: :collection
  end

  resources :requests, only: [:index, :edit, :update, :destroy] do
    put :confirm, on: :member
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
