ActionController::Routing::Routes.draw do |map|

  # contest_year is prepended to paths.
  map.filter :contest_year, :file => "#{RAILS_ROOT}/lib/routing_filter_for_contest_year"

  map.root :controller => 'home', :action => 'index'

  # sessions.
  map.login 'login', :controller => :sessions, :action => :new
  map.session 'create_session', :controller => :sessions, :action => :create, :conditions => {:method => :post}
  map.logout 'logout', :controller => :sessions, :action => :destroy
  map.login_admin 'login_admin', :controller => :sessions, :action => :new_admin
  map.session_admin 'create_session_admin', :controller => :sessions, :action => :create_admin, :conditions => {:method => :post}

  map.resources :players do |player|
    # Can these be taken care of by the :shallow option?
    player.edit_picks '/picks/edit', :controller => :picks, :action => :edit
    player.update_picks '/picks/update', :controller => :picks, :action => :update, :conditions => {:method => :put}
    player.resources :picks, :only => 'index'
    player.resources :entries, :only => :create
  end

  map.resources :films
  map.resources :categories
  map.resources :nominees, :member => {:declare_winner => :put}
  map.resources :entries, :only => :index

  map.connect '/auth/failure', :controller => 'sessions', :action => 'failure'
  map.connect '/auth/:provider/callback', :controller => 'sessions', :action => 'create'

  map.toggle_picks_editable '/admin/toggle_picks_editable', :controller => 'admin', :action => 'toggle_picks_editable', :conditions => {:method => :put}

end
