Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :end_users do
    root to: 'home#index'
    resources :end_users do
      member do
        get :following, :followers
      end
    end
    resources :posts, only: [:create, :show, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :favorites, only: [:index]
    resources :relationships, only: [:create, :destroy]
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    get '/quizes', to: 'quizes#take'
    post '/quizes/result', to: 'quizes#result'
    get '/lowroom', to: 'rooms#lowroom'
    get '/midroom', to: 'rooms#midroom'
    get '/upperroom', to: 'rooms#upperroom'
  end
end
