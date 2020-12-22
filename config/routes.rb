Rails.application.routes.draw do
  devise_for :users
  resources :items
  root to: "items#index"
  get 'orders/:id', to: 'orders#index'
end
