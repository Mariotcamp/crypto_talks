Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :end_users do
    root to: 'home#index'
    resources :end_users
  end
end
