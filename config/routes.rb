Rails.application.routes.draw do
  root 'static_pages#home'
  resources :transactions
  resources :accounts
end
