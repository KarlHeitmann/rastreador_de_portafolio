Rails.application.routes.draw do
  resources :wallets do
    resources :operations
  end
  get 'wallets/:id/add_funds', to: 'wallets#add_funds', as: 'add_funds'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'wallets#index'
end
