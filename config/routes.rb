Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "welcome/index"
  # Defines `root_url`. Devise requires this to be set
  root to: "welcome#index"
end
