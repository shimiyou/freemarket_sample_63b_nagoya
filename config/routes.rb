Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items, only: [:index, :new, :create, :show, :edit]
  resources :users, only: [:index,:new, :create, :edit, :show] do
    collection do
      get "logout"
    end 
  end
  resources :signup, only: [:create] do
    collection do
      get "detail"
      get "phone_number"
      get "address"
      get "pay"
      get "fin"
    end 
  end
  resources :cards, only: [:create, :show, :new] do

  end 
end
