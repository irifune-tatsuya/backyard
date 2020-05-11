Rails.application.routes.draw do
  devise_for :users
  root to: 'branches#index'
  resources :branches, only: [:new, :create]
end
