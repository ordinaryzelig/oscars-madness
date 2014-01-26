OscarsMadness::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  root :controller => 'home', :action => 'index'
  get 'about', :controller => 'home', :action => 'about'

  # sessions.
  get    'login'                => 'sessions#new', as: :login_form
  post   'create_session'       => 'sessions#create', as: :login
  get    'logout'               => 'sessions#destroy', as: :logout

  resources :players do
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
end
