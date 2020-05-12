Rails.application.routes.draw do
  devise_for :users
  root to: 'branches#index'
  resources :branches, only: [:new, :create] do
    resources :employees, only: [:index, :create]
  end
  resources :employees, only: :new
end
