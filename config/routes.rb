Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users

  resources :events, only: %i[new edit create update destroy]
end
