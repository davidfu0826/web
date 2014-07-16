Rails.application.routes.draw do

  root 'posts#index'
  devise_for :users

  resources :posts, except: [:show]
  get 'feed', to: 'posts#feed'

  resources :nav_items

  get ':id', to: 'pages#show', as: :page
  resources :pages, except: :show
end
