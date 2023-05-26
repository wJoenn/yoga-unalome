Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :events, only: %i[new create update destroy]
  get "user_dashboard/show", as: :dashboard
end
