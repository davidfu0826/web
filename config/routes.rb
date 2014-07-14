Rails.application.routes.draw do

  root 'pages#index'
  devise_for :users

  resources :posts, except: [:index, :show]

  get ':id', to: 'pages#show', as: :page
  resources :pages, except: :show
end
