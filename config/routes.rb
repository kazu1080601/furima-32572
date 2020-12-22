Rails.application.routes.draw do
  devise_for :users
  resources :items
  resources :orders, only: :index
  root to: "items#index"
end
