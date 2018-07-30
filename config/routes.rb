Rails.application.routes.draw do
  get 'static_pages/home'
  resources :transactions
  resources :accounts
  root 'static_pages#home'
end
