Rails.application.routes.draw do
  root 'page#index'

  devise_for :users

  resources :posts
end
