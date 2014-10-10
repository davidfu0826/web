Rails.application.routes.draw do

  mount RailsSettingsUi::Engine, at: 'settings'
  get "sitemap.xml" => "application#sitemap", format: :xml, as: :sitemap
  get "robots.txt" => "application#robots", format: :text, as: :robots

  root 'posts#index'
  devise_for :users
  resources :users, except: :show

  get 'locale_sv', to: 'locale#locale_sv', as: 'swedish_locale'
  get 'locale_en', to: 'locale#locale_en', as: 'english_locale'
  get 'tweets', to: 'tweets#tweets'

  resources :tags, except: [:show]
  resources :posts do
    get 'archive', on: :collection
  end

  resources :images, except: :show do
    get 'search', on: :collection
  end

  resources :events do
    collection do
      get 'change_cover'
      post 'change_cover', to: 'events#change_cover_update', as: 'change_cover_update'
      delete 'delete_cover'
    end
  end

  resources :nav_items, except: [:index, :show] do
    member do
      get 'move_higher'
      get 'move_lower'
    end
  end

  get 'pages', to: 'pages#index'
  get ':id', to: 'pages#show', as: :page
  delete ':id', to: 'pages#destroy'
  resources :pages, except: [:show, :delete, :index], shallow: true do
    member do
      get 'add_user'
      post 'add_user', to: 'pages#add_user_update'
      get 'change_cover'
      delete 'delete_cover'
    end
    resources :contact_forms do
      post 'send_mail', on: :member
    end
  end
end
