Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users

  resources :events, only: %i[new create update destroy] do
    resources :bookings, only: %i[create update] do
      patch :cancelation, on: :member
    end
  end
end
