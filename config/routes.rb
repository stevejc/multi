Multi::Application.routes.draw do
  devise_for :users
  root 'welcome#index'
  resources :accounts
  resources :clients

  get 'pricing', to: 'welcome#pricing'
end
