Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get 'welcome/index', to: 'welcome#index'
  get '/protected', to: 'welcome#protected'

  # Defines where '/' routes to, sets `root_url`.
  # The devise gem requires this to be set
  root to: "welcome#index"
end
