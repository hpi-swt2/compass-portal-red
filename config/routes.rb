Rails.application.routes.draw do

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

  # starts the navigation with the coordinates provided in the coordinates-parameter
  # example: /navigation/13p12976840232745%2C52p393810752008136;13p130358602111253%2C52p39362748477138 
  # navigation/<LONG1>%2C<LAT1>;<LONG2>%2C<LAT2>
  get '/navigation/:coordinates', to: 'map#navigation'


  # '/'
  # Sets `root_url`, devise gem requires this to be set
  devise_scope :user do
    root to: "users/sessions#new"
  end

  get 'indoor/demo/', to: 'indoor#demo'
  get 'indoor/json/', to: 'indoor#geojson'
end
