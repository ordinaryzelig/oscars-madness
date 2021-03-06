OscarsMadness::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  root 'home#index'

  get 'picks/edit' => 'picks#edit', as: :edit_picks
  put 'picks/update' => 'picks#update', as: :update_picks

  # sessions.
  get  'login'  => 'sessions#new', as: :login
  post 'login'  => 'sessions#create'
  get  'logout' => 'sessions#destroy', as: :logout

  # Omniauth
  get '/auth/failure'            => 'sessions#failure'
  get '/auth/:provider/callback' => 'sessions#create'

  get '/privacy' => 'home#privacy'
end
