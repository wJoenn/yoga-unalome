Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users

  resources :sessions, only: %i[create update destroy] do
    resources :bookings, only: %i[create update] do
      patch :cancelation, on: :member
    end
  end
end
