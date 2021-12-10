Rails.application.routes.draw do
  resources :wallets do
    resources :operations
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'wallets#index'
end
