Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: "users/sessions"
  }

  get "user_dashboard/show", as: :dashboard

  resources :events, only: %i[new edit create update destroy] do
    resources :bookings, only: %i[create]
  end

  patch "/bookings/:id/cancel", to: "bookings#cancel", as: :cancel_booking
end
