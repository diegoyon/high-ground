Rails.application.routes.draw do
  resources :athletes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  get "/success", to: "home#success"
end
