Rails.application.routes.draw do
  get 'package_packages/index'
  devise_for :users
  root to: 'deliveries#index', period: "today"

  resources :deliveries, only: [:create, :update, :index]
  resources :companies, only: [:new, :create]

  get '/deliveries/bulk-new', to: 'deliveries#bulk_new'
  post 'deliveries/bulk-create', to: 'deliveries#bulk_create'

  resources :deliveries do
    collection do
      get 'phone', to: "deliveries#phone"
    end
    collection do
      get 'photo', to: "deliveries#photo"
    end
  end

  # Webooks
  post '/webhooks/onfleet/:token/task-completed', to: 'onfleet_webhooks#task_completed'
  get '/webhooks/onfleet/:token/task-completed', to: 'onfleet_webhooks#task_completed'
end
