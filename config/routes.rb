Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items, only: [:index, :new, :create, :show, :edit, :destroy] do
    collection do
      get "buy"
    end
  end
  resources :users, only: [:index,:new, :create, :edit, :show] do
    collection do
      get "logout"
      get "check"
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
