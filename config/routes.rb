Multi::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  root 'welcome#index'
  resources :accounts
  resources :clients
  resources :users
  
  get 'pricing', to: 'welcome#pricing'
end
