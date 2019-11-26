Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items, only: [:index, :new, :show, :edit]
  resources :users, only: [:new, :create, :edit, :show]
end
