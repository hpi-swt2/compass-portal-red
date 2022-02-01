Rails.application.routes.draw do

  resources :courses
  resources :email_log
  resources :data_problems
  resources :chairs
  resources :buildings
  resources :rooms
  resources :floors
  resources :people
  resources :person_urls

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # '/users/...'
  # https://github.com/plataformatec/devise#configuring-routes
  devise_for :users, path: 'users',
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      omniauth_callbacks: 'users/omniauth_callbacks'
    }

  # '/protected'
  get '/protected', to: 'welcome#protected'

  # '/search'
  get '/search', to: 'search#index'

  # '/map'
  get '/map', to: 'map#index'
  get '/directions/:profile/:coordinates', to: 'map#directions'

  # starts the navigation from the current location to the provided coordinate-position
  # example: /navigation/13p12976840232745%2C52p393810752008136
  # navigation/<LONG1>%2C<LAT1>
  get '/navigation/:coordinate', to: 'map#navigation'

  # '/options'
  get '/options', to: 'options#index'
  # '/'
  # Sets `root_url`, devise gem requires this to be set
  devise_scope :user do
    root to: 'users/sessions#new'
    get '/users/sign_out', to: 'users/sessions#destroy'
  end

  get 'indoor/demo/', to: 'indoor#demo'
  get 'indoor/json/', to: 'indoor#geojson'
end
