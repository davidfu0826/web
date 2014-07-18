Rails.application.routes.draw do

  root 'posts#index'
  devise_for :users
  resources :users, except: :show
  get 'users/:id/new_password_email', to: 'users#new_password_email', as: 'user_new_password_email'

  resources :posts, except: [:show]
  get 'feed', to: 'posts#feed'

  resources :images, except: [:show, :edit, :update]

  resources :tags, except: [:show]

  resources :events
  resources :event_groups, only: [:new, :create]

  resources :nav_items
  get 'nav_items/:id/move_higher', to: 'nav_items#move_higher', as: 'nav_item_higher'
  get 'nav_items/:id/move_lower', to: 'nav_items#move_lower', as: 'nav_item_lower'

  get 'pages', to: 'pages#index'
  get ':id', to: 'pages#show', as: :page
  patch ':id', to: 'pages#update'
  delete ':id', to: 'pages#destroy'
  get ':id/add_user', to: 'pages#add_user', as: 'page_add_user'
  post ':id/add_user', to: 'pages#add_user_update', as: 'page_add_user_update'
  resources :pages, except: [:show, :update, :destroy, :index]
end
