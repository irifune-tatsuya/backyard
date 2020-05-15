Rails.application.routes.draw do
  devise_for :users
  root 'branches#index'
  resources :branches, only: [:new, :create, :edit, :update, :destroy] do
    resources :employees, only: :index
    resources :holidays, only: [:new, :create]
  end
  resources :holidays, only: [:index, :destroy]
  resources :employees, only: [:new, :create, :edit, :update, :destroy]
end
