Rails.application.routes.draw do
  resources :fri_athletes, only: [:new, :create]
  resources :recurrente_athletes, only: [:new, :create]
  resources :athletes, only: [:index]
  resources :leaderboard, only: [:index]
  resources :workouts

  root "home#index"

  get "/success", to: "home#success"
  get "/payment_completed", to: "home#payment_completed"
  get "/payment_failed", to: "home#payment_failed"
  get "/payment_options", to: "home#payment_options"

  post "webhooks/fri", to: "webhooks#fri"
  post "webhooks/recurrente", to: "webhooks#recurrente"
end
