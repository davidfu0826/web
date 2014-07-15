Rails.application.routes.draw do

  root 'pages#index'
  devise_for :users

  resources :posts, except: [:show]
  get 'feed', to: 'posts#feed'

  get ':id', to: 'pages#show', as: :page
  resources :pages, except: :show
end
