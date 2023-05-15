Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users

  resources :events, only: %i[create update destroy] do
    resources :bookings, only: %i[create] do
      patch :cancel_booking, on: :member
    end
  end
end
