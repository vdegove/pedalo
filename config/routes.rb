Rails.application.routes.draw do
  devise_for :users
  root to: 'deliveries#today'

  resources :deliveries, only: [:create, :update, :index]
  resources :companies, only: [:new, :create]

  get '/deliveries/bulk-new', to: 'deliveries#bulk_new'
  post 'deliveries/bulk-create', to: 'deliveries#bulk_create'

  resources :deliveries do
    collection do
      get 'past', to: "deliveries#past"
    end
    collection do
      get 'upcoming', to: "deliveries#upcoming"
    end
    collection do
      get 'today', to: "deliveries#today"
    end
  end

  # Webooks
  post '/webhooks/onfleet/:token/task-completed', to: 'onfleet_webhooks#task_completed'
  get '/webhooks/onfleet/:token/task-completed', to: 'onfleet_webhooks#task_completed'
end
