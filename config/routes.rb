Multi::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  root 'welcome#index'
  resources :accounts
  post 'change_account', to: "accounts#change_account"
  resources :clients
  resources :users
  post 'invite', to: 'user_accounts#invite_user'
  
  get 'pricing', to: 'welcome#pricing'
  get 'add_account', to: 'accounts#add_another_account'
end
