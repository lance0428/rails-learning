Rails.application.routes.draw do
  resources :transactions
  resources :accounts
  root 'accounts#index'
end
