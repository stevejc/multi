require 'sidekiq/web'

Multi::Application.routes.draw do
  %w( 404 422 500 ).each do |code|
    match code, :to => "errors#show", :code => code, via: :all
  end

  devise_for :users, :controllers => { :registrations => "registrations" }
  root 'welcome#index'
  resources :accounts
  post 'change_account', to: "accounts#change_account"
  resources :clients
  resources :users
  post 'invite', to: 'users#invite_user'
  get 'pricing', to: 'welcome#pricing'
  get 'add_account', to: 'accounts#add_another_account'
  get '/main' =>  'main#index'
  mount Sidekiq::Web, at: '/sidekiq'
  

  
end
