Rails.application.routes.draw do

  root 'page#index'

  devise_for :users
  # You can have the root of your site routed with "root"
  # root 'welcome#index'
end
