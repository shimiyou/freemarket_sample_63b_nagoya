Rails.application.routes.draw do
  devise_for :users,controllers: {omniauth_callbacks: "users/omniauth_callbacks", registrations: "registrations"}
  root to: 'items#index'
  resources :items, only: [:index, :new, :create, :show, :edit, :destroy, :update] do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
    member do
      get "buy"
      get 'done'
      post "pay"
    end
  end
  resources :users, only: [:index,:new, :edit, :show] do
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
      get "fin"
    end 
  end
  resources :cards, only: [:create, :new] 
end
