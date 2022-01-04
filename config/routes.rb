Rails.application.routes.draw do

  resources :chairs
  resources :rooms
  resources :people

  resources :person_urls

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

  # '/search'
  get '/search', to: 'search#index'

  # '/map'
  get '/map', to: 'map#index'

  # '/'
  # Sets `root_url`, devise gem requires this to be set
  root to: "search#index"

  get 'indoor/demo/', to: 'indoor#demo'
  get 'indoor/json/', to: 'indoor#geojson'
end
