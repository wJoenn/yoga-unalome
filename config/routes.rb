Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users

  resources :events, only: %i[create update destroy] do
    resources :bookings, only: %i[create]
  end

  resources :bookings, only: %i[] do
    member do
      patch :cancel, as: :cancel_booking
    end
  end
end
