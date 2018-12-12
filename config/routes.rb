Rails.application.routes.draw do

  devise_for :users


  authenticated :user do
      root to: 'deliveries#dashboard'
  end

  root 'pages#home', as: :authenticated_root
  # root to: 'deliveries#index', period: "today"


  get '/deliveries/bulk-new', to: 'deliveries#bulk_new'
  post 'deliveries/bulk-create', to: 'deliveries#bulk_create'
  patch "deliveries/:id", to: "deliveries#update", as: 'update'


#  get '/deliveries?period=today', to: 'deliveries#index', as: 'deliveries'
#  resources :deliveries, only: [:create, :update, :show, :edit, :bulk_update]
  
  get '/deliveries', to: 'deliveries#index', as: 'deliveries'
  resources :deliveries, only: [:create, :update, :show]

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
end
