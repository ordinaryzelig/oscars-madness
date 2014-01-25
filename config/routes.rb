OscarsMadness::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  # contest_year is prepended to paths.
  #map.filter :contest_year, :file => "#{RAILS_ROOT}/lib/routing_filter_for_contest_year"

  root :controller => 'home', :action => 'index'
  get 'about', :controller => 'home', :action => 'about'

  # sessions.
  get    'login'                => 'sessions#new', as: :login_form
  post   'create_session'       => 'sessions#create', as: :login
  get    'logout'               => 'sessions#destroy', as: :logout
  get    'login_admin'          => 'sessions#new_admin', as: :login_admin_form
  post   'create_session_admin' => 'sessions#create_admin', as: :login_admin

  resources :players do
    resources :entries, only: [:create]
    resources :picks, only: [:index] do
      collection do
        get 'edit'
        put 'update', as: :update
      end
    end
  end

  resources :categories, only: [:show]

  # Omniauth
  get '/auth/failure'            => 'sessions#failure'
  get '/auth/:provider/callback' => 'sessions#create'

  put '/admin/toggle_picks_editable' => 'admin#toggle_picks_editable', as: :toggle_picks_editable
end
