ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => 'home', :action => 'index'
  
  # sessions.
  map.login 'login', :controller => :sessions, :action => :new
  map.session 'create_session', :controller => :sessions, :action => :create, :conditions => {:method => :post}
  map.logout 'logout', :controller => :sessions, :action => :destroy
  map.login_admin 'login_admin', :controller => :sessions, :action => :new_admin
  map.session_admin 'create_session_admin', :controller => :sessions, :action => :create_admin, :conditions => {:method => :post}
  
  map.resources :players do |player|
    player.edit_picks '/picks/edit', :controller => :picks, :action => :edit
    player.update_picks '/picks/update', :controller => :picks, :action => :update, :conditions => {:method => :put}
    player.resources :picks
  end
  
  map.resources :films
  map.resources :categories
  map.resources :nominees, :member => {:declare_winner => :put}
  
end
