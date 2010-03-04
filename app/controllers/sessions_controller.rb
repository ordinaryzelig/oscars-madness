class SessionsController < ApplicationController
  
  before_filter :logout, :except => [:create, :create_admin]
  
  def new
    
  end
  
  def create
    name = params[:player][:name]
    password = params[:player][:password].digest if params[:player][:password]
    player = Player.find_by_name_and_password(name, password)
    if player
      session[:player_id] = player.id
      session[:admin_logged_in] = false
      redirect_to player_edit_picks_path(player)
    else
      flash[:error] = "login failed"
      redirect_to login_path
    end
  end
  
  def destroy
    redirect_to root_path
  end
  
  def new_admin
    
  end
  
  def create_admin
    if admin_config.admin_password == params[:player][:password].digest
      session[:admin_logged_in] = true
      redirect_to root_path
      return
    end
    redirect_to login_admin_path
  end
  
  private
  
  def logout
    cookies.delete :"_oscars-madness_session"
    reset_session
  end
  
end
