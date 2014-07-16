Rails.application.routes.draw do

  root 'posts#index'
  devise_for :users

  resources :events
  resources :event_groups, only: [:new, :create]
  resources :posts, except: [:show]
  get 'feed', to: 'posts#feed'

  resources :nav_items
  get ':id', to: 'pages#show', as: :page
  patch ':id', to: 'pages#update'
  resources :pages, except: [:show, :update] do
    get 'add_user', to: :add_user
    post 'add_user', to: :add_user_update
  end
end
