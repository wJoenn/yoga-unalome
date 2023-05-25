Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users

  resources :events, only: %i[new create update destroy]
    resources :bookings, only: %i[create] do
      patch :cancel, as: :cancel_booking, on: :member
    end
  get "user_dashboard/show", as: :dashboard
end
