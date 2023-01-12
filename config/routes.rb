Rails.application.routes.draw do
  # Pages routes
  root to: 'pages#welcome'

  get       '/campaigns',         to: 'pages#campaigns',          as: 'all_campaigns'
  get       '/about',             to: 'pages#about',              as: 'about'
  get       '/giftcard',          to: 'pages#giftcard',           as: 'giftcard'
  get       '/checkgiftcard',     to: 'pages#checkgiftcard',      as: 'checkgiftcard'
  get       '/howitworks',        to: 'pages#howitworks',         as: 'howitworks'
  get       '/faq',               to: 'pages#faq',                as: 'faq'
  get       '/generalfund',       to: 'pages#generalfund',        as: 'generalfund'
  get       '/share',             to: 'pages#share',              as: 'share'
  get       '/privacy',           to: 'pages#privacy',            as: 'privacy'
  get       '/terms',             to: 'pages#terms',              as: 'terms'
  get       '/holidays',          to: 'pages#holidays',           as: 'holiday'
  get       '/givingtuesday',     to: 'pages#givingtuesday',      as: 'givingtuesday'
  get       '/covid19',           to: 'pages#covid19',            as: 'covid19'
  get       '/get_donors/:id',        to: 'campaigns#get_donors',     as: 'get_donors'

  # mailers
  get      '/holiday-donation',  to: 'messages#holiday_mailer',  as: 'holiday_mailer'

  # donors routes provided by devise
  devise_for :donors, controllers: { sessions: 'donors/sessions', registrations: 'donors/registrations', omniauth_callbacks: 'donors/omniauth_callbacks' }

  # donors routes
  resources  :donors, only: %i[index show], path: 'donors'

  # categories and projects routes
  resources :categories, only: [] do
    resources :projects, only: [:index]
  end

  # routes for campaign
  resources :campaigns do
    resources :championship_requests, only: %i[new create]

    member do
      get :thank_you
    end
  end
  get    '/campaigns/:campaign_id/donations',     to: 'donations#index', as: 'donations'
  get    '/campaigns/:campaign_id/donations/new', to: 'donations#new', as: 'new_donation'

  resources :championships, only: %i[edit update destroy]

  resources :comments, except: %i[show]

  # routes for beneficiaries
  resources :beneficiaries, except: [:index]

  # routes for blog_post
  resources :blog_posts, only: %i[index show]
  get 'blog/health', to: 'blog_posts#index', tag: 'health'
  get 'blog/education', to: 'blog_posts#index', tag: 'education'
  get 'blog/fundraising', to: 'blog_posts#index', tag: 'fundraising'
  get 'blog/success', to: 'blog_posts#index', tag: 'success'

  # route for paypal
  post 'paypal-transaction-complete', to: 'donations#paypal_payment', as: 'paypal-transaction-complete'

  # route for gift card payment
  post 'donation/giftcardpayment', to: 'donations#gift_card_payment', as: 'giftcardpayment'

  # route for square up payment
  post '/donations/squareup/process', to: 'donations#squareup_payment', as: :squareup_payment

  namespace :api do
    namespace :emergent do
      get 'campaigns'
      get 'validate_campaign'
      post 'payment'
    end
  end

  devise_for :admin_users, controllers: {
    sessions: 'admin_users/sessions',
    unlocks: 'admin_users/unlocks'
  }

  # Start: Admin Routes
  get '/admin', to: 'admin#index', as: 'admin_user_root'
  namespace :admin do
    get 'projects',             to: 'special#all_projects',      as: 'restricted_all_projects'
    get 'categories',           to: 'special#all_categories',    as: 'restricted_all_categories'
    get 'new-project',          to: 'special#new_projects',      as: 'restricted_new_project'
    post 'new_donation',        to: 'special#new_donation',      as: 'admin_donation'
    get 'campaignpreview/:id',  to: 'special#preview',           as: 'preview_campaign'
    get 'project/:id/donations',to: 'special#project_donations', as: 'project_donations'
    get 'settings',             to: 'special#settings',          as: 'settings'
    put 'settings',             to: 'special#update_rate'
    get 'blog_posts',           to: 'special#all_blog_posts'
    get 'export_donations',     to: 'donations#export_donations',  as: 'export_donations'

    resources :beneficiaries, except: %i[index show]
    resources :campaigns, except: %i[index show]
    resources :categories, except: %i[index show]
    resources :championship_requests, only: %i[index edit update]
    resources :championships
    resources :donations, only: %i[index]
    resources :projects, except: %i[index show]
    resources :blog_posts, except: %[index show]

    get '/get_donations',        to: 'donations#get_donations',     as: 'get_donations'
  end
  
end
