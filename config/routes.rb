Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # '/users/...'
  # https://github.com/plataformatec/devise#configuring-routes
  devise_for :users, path: 'users',
    controllers: {
      registrations: 'users/registrations',
      omniauth_callbacks: 'users/omniauth_callbacks'
    }

  # '/protected'
  get '/protected', to: 'welcome#protected'
  get '/map', to: 'welcome#map'

  # '/'
  # Sets `root_url`, devise gem requires this to be set
  root to: "welcome#index"

  get '/demo', to: 'indoor#demo'
end
