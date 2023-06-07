Rails.application.routes.draw do
  root to: "pages#home"

  authenticate :user, ->(user) { user.admin? } do
    mount GoodJob::Engine => "good_job"
  end

  mount StripeEvent::Engine, at: "stripe-webhook"

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: "users/sessions"
  }

  get "user_dashboard/show", as: :dashboard

  resources :events, only: %i[new edit create update destroy] do
    member do
      get :confirmation, as: :confirm_booking
    end

    resources :bookings, only: %i[create]
  end

  get "bookings/payment_canceled", to: "bookings#payment_canceled", as: :canceled_payment
  get "bookings/payment_successful", to: "bookings#payment_successful", as: :successful_payment
  patch "bookings/:id/cancel", to: "bookings#cancel", as: :cancel_booking
end
