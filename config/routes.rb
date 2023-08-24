Rails.application.routes.draw do
  resources :athletes
  root "home#index"
  get "/success", to: "home#success"
  post "webhooks/fri", to: "webhooks#fri"
end
