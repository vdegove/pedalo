Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :deliveries, only: [:new, :create, :update]
  resources :companies, only: [:new, :create]

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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
