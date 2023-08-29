Rails.application.routes.draw do
  resources :athletes, only: [:new, :create]
  root "home#index"
  get "/success", to: "home#success"
  post "webhooks/fri", to: "webhooks#fri"
end
