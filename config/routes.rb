Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :users, only: [:index, :show]

  resources :rounds, only: [:index, :show, :new, :create, :update] do
    resources :votes, only: [:new, :create]

    get 'finalize', on: :member
  end
end
