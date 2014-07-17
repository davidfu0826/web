Rails.application.routes.draw do

  root 'posts#index'
  devise_for :users
  resources :users, except: [:show]

  resources :users, only: [:index, :edit, :update]
  resources :events
  resources :event_groups, only: [:new, :create]
  resources :posts, except: [:show]
  get 'feed', to: 'posts#feed'

  resources :nav_items
  get 'nav_items/:id/move_higher', to: 'nav_items#move_higher', as: 'nav_item_higher'
  get 'nav_items/:id/move_lower', to: 'nav_items#move_lower', as: 'nav_item_lower'

  get 'pages', to: 'pages#index'
  get ':id', to: 'pages#show', as: :page
  patch ':id', to: 'pages#update'
  delete ':id', to: 'pages#destroy'
  get ':id/add_user', to: 'pages#add_user'
  post ':id/add_user', to: 'pages#add_user_update'
  resources :pages, except: [:show, :update, :destroy, :index]
end
