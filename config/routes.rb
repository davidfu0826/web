Rails.application.routes.draw do

  root 'posts#index'
  devise_for :users

  resources :users, only: [:index, :edit, :update]
  resources :events
  resources :event_groups, only: [:new, :create]
  resources :posts, except: [:show]
  get 'feed', to: 'posts#feed'

  resources :nav_items do
    get 'move_higher', to: :move_higher, as: 'higher'
    get 'move_lower', to: :move_lower, as: 'lower'
  end
  get 'pages', to: 'pages#index'
  get ':id', to: 'pages#show', as: :page
  patch ':id', to: 'pages#update'
  delete ':id', to: 'pages#destroy'
  resources :pages, except: [:show, :update, :destroy, :index] do
    get 'add_user', to: :add_user
    post 'add_user', to: :add_user_update
  end
end
