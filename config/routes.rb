Rails.application.routes.draw do
  root to: 'items#index'
  resources :items, only: [:index, :new, :show, :edit]
  resources :users, only: [:index,:new, :create, :edit, :show]
end
