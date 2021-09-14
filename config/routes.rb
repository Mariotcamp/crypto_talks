Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :end_users do
    root to: 'home#top'
    resources :end_users do
      member do
        get :following, :followers
        post :withdraw
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
  namespace :admin_users do
    get '/', to: 'home#top'
    resources :quizes, only: [:index, :new, :create, :destroy]
    resources :end_users, only: [:index]
    post '/recover/:id', to: 'end_users#recover'
    post '/ban/:id', to: 'end_users#ban'
  end
end
