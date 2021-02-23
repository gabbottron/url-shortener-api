Rails.application.routes.draw do
  # Disabling Devise routig because I am implementing
  # my own simplified Create User / Login routes
  #devise_for :users
  
  # New user controller will use devise
  # on the backend for user management
  namespace :users do
    post 'new'
    post 'login'
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
