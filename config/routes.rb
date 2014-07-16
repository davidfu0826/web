Rails.application.routes.draw do

  root 'pages#index'
  devise_for :users

  resources :events
  resources :posts, except: [:show]
  get 'feed', to: 'posts#feed'

  resources :nav_items
  get ':id', to: 'pages#show', as: :page
  resources :pages, except: :show do
    get 'add_user', to: :add_user
    post 'add_user', to: :add_user_update
  end
end
