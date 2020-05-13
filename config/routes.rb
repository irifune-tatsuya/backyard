Rails.application.routes.draw do
  devise_for :users
  root 'branches#index'
  resources :branches, only: [:new, :create] do
    resources :employees, only: :index
    resources :holidays, only: [:new, :create]
  end
  resources :holidays, only: :index
  resources :employees, only: [:new, :create]
end
