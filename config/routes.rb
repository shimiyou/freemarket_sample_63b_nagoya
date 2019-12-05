Rails.application.routes.draw do
  devise_for :users,controllers: {omniauth_callbacks: "users/omniauth_callbacks", registrations: "registrations"}
  root to: 'items#index'
  resources :items, only: [:index, :new, :show, :edit]
  resources :users, only: [:index,:new, :create, :edit, :show] do
    collection do
      get "detail"
      get "phone_number"
      get "address"
      get "pay"
      get "fin"
      get "logout"
    end 
  end
end
