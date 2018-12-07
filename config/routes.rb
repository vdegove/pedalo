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
    collection do
      get 'name', to: "deliveries#name"
    end
    collection do
      get 'phone', to: "deliveries#phone"
    end
    collection do
      get 'photo', to: "deliveries#photo"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
