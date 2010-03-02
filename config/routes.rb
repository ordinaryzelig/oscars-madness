ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => 'home', :action => 'index'
  
  map.resources :players do |player|
    player.edit_picks '/picks/edit', :controller => :picks, :action => :edit
    player.update_picks '/picks/update', :controller => :picks, :action => :update, :conditions => {:method => :put}
    player.resources :picks
  end
  
  map.resources :picks, :only => :index, :member => {:declare_winner => :put}
  map.resources :films
  map.resources :categories
  map.resources :nominees
  
end
