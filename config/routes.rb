Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users

  resources :events, only: %i[new create update destroy]
  get "user_dashboard/show", as: :dashboard
end
