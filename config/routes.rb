Rails.application.routes.draw do

  get "sitemap.xml" => "application#sitemap", format: :xml, as: :sitemap
  get "robots.txt" => "application#robots", format: :text, as: :robots

  root 'posts#index'
  devise_for :users
  resources :users, except: :show

  get 'posts/archive', to: 'posts#archive', as: 'posts_archive'
  resources :posts
  get 'tweets', to: 'tweets#tweets'

  resources :images, except: :show
  get 'images/search', to: 'images#search', as: 'images_search'

  resources :tags, except: [:show]

  get 'events/change_cover', to: 'events#change_cover', as: 'events_change_cover'
  post 'events/change_cover', to: 'events#change_cover_update', as: 'events_change_cover_update'
  delete 'events/delete_cover', to: 'events#delete_cover', as: 'events_delete_cover'
  resources :events

  resources :nav_items, except: [:index, :show]
  get 'nav_items/:id/move_higher', to: 'nav_items#move_higher', as: 'nav_item_higher'
  get 'nav_items/:id/move_lower', to: 'nav_items#move_lower', as: 'nav_item_lower'

  get 'locale_sv', to: 'locale#locale_sv', as: 'swedish_locale'
  get 'locale_en', to: 'locale#locale_en', as: 'english_locale'

  get 'pages', to: 'pages#index'
  get ':id', to: 'pages#show', as: :page
  patch ':id', to: 'pages#update'
  delete ':id', to: 'pages#destroy'
  get ':id/add_user', to: 'pages#add_user', as: 'page_add_user'
  post ':id/add_user', to: 'pages#add_user_update', as: 'page_add_user_update'
  post 'contact_forms/:id/send_mail', to: 'contact_forms#send_mail', as: 'contact_form_send_mail'
  resources :pages, except: [:show, :update, :destroy, :index], shallow: true do
    get 'change_cover', to: :change_cover, as: 'change_cover'
    delete 'delete_cover', to: :delete_cover, as: 'delete_cover'
    resources :contact_forms
  end
end
