Rails.application.routes.draw do
  
  get :karnytt, to: redirect('http://karnytt.dsgdev.com/'), status: 301
  get :fmval, to: redirect('http://fmval.tlth.se/'), status: 301
  get 'sitemap.xml.gz', to: redirect(Rails.configuration.x.sitemap_url),
                        as: :sitemap
  get 'robots.:format', controller: :static_pages, action: :robots, as: :robots
  get 'files/uploads/logo-mail.png', controller: :static_pages, action: :logo_mail
  get :board, controller: :static_pages
  get :council, controller: :static_pages, path: 'the-representative-council'

  root 'posts#index'
  devise_for :users
  resources  :users, except: :show

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  get 'locale_sv', to: 'locale#locale_sv', as: 'swedish_locale'
  get 'locale_en', to: 'locale#locale_en', as: 'english_locale'
  get 'tweets', to: 'tweets#index'

  resources :tags, except: [:show]
  resources :posts, concerns: :paginatable do
    get 'archive', on: :collection
  end

  resources :images, concerns: :paginatable do
    get 'search', on: :collection
  end

  resources :uploads, except: [:edit, :update], concerns: :paginatable do
    get :search, on: :collection
  end

  resources :documents
  get :styrdokument, controller: :documents, action: :index

  resources :positions, except: [:show]

  resources :meetings, except: [:show], path_names: { edit: '' } do
    resources :meeting_documents, only: [:destroy, :update]
  end

  resources :meeting_documents, only: :show

  resources :events

  resources :nav_items, except: [:index, :show] do
    member do
      get 'move_higher'
      get 'move_lower'
    end
    post :update_order, on: :collection
  end

  resources :sabbatical_officers, only: [:new, :index, :create,
                                         :edit, :update, :destroy],
                                  path: 'sabbatical-officers'
  get :heltidare, controller: :sabbatical_officers, action: :index

  get  :settings, to: 'settings#edit'
  post :settings, to: 'settings#update'

  get    'pages', to: 'pages#index'
  get    ':id',   to: 'pages#show', as: :page
  patch  ':id',   to: 'pages#update'
  delete ':id',   to: 'pages#destroy'

  resources :pages, shallow: true, except: [:show, :delete, :index] do
    member do
      get    'add_user'
      post   'add_user',    action: :add_user_update
      delete 'remove_user', action: :remove_user
      get    'change_cover'
      delete 'delete_cover'
    end

    resources :contact_forms do
      post 'send_mail', on: :member
    end
  end
end
