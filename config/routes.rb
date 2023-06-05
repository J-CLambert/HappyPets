Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :pets do
    resources :requests, only: [:index, :new, :create]
  end

  resources :requests, only: [:edit, :update, :destroy]

  resources :requests do
    put :confirm, on: :member
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
