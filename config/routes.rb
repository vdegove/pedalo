Rails.application.routes.draw do

  devise_for :users


  authenticated :user do
      root to: 'deliveries#dashboard'
  end
  root 'pages#home'
  get "/pages/home", to: "pages#home"
  # root to: 'deliveries#index', period: "today"

# For debugging bulk create
get 'deliveries/test-bulk-create', to: 'deliveries#test_bulk_create'


  get '/deliveries/bulk-new', to: 'deliveries#bulk_new'
  post 'deliveries/bulk-create', to: 'deliveries#bulk_create'


  get '/deliveries', to: 'deliveries#index', as: 'deliveries'
  resources :deliveries, only: [:create, :update, :show] do
    resources :delivery_packages, only: [:index, :create]
  end
  resources :delivery_packages, only: :update
  # resources :delivery_packages, only: [:new, :show, :edit, :update]
  resources :companies, only: [:new, :create]
  get '/dashboard', to: 'deliveries#dashboard'



  # resources :deliveries do
  #   collection do
  #     get 'phone', to: "deliveries#phone"
  #   end
  #   collection do
  #     get 'photo', to: "deliveries#photo"
  #   end
  # end


  resources :delivery_packages, only: [:edit, :update, :new]


  # Webooks
  post '/webhooks/onfleet/:token/task-completed', to: 'onfleet_webhooks#task_completed'
  get '/webhooks/onfleet/:token/task-completed', to: 'onfleet_webhooks#task_completed'
  post '/webhooks/onfleet/:token/driver-assigned', to: 'onfleet_webhooks#driver_assigned'
  get '/webhooks/onfleet/:token/driver-assigned', to: 'onfleet_webhooks#driver_assigned'


  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
