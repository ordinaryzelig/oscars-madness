class SessionsController < ApplicationController

  before_filter :logout, :except => [:create, :create_admin]

  def new
  end

  def create
    if request.env['omniauth.auth']
      omniauth = request.env['omniauth.auth']
      player = Player.find_or_create_by_omniauth(omniauth)
    else
      player = Player.authenticate(params[:player][:name], params[:player][:password])
    end
    if player
      if Contest.this_year?
        player.entries.create! :year => Date.today.year unless player.participating_this_year?
      end
      session[:player_id] = player.id
      session[:admin_logged_in] = false
      redirect_to edit_player_picks_path(player)
    else
      flash.now[:error] = "login failed"
      render :new
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

  def failure
    flash[:error] = 'Sorry, something went wrong. Try again later.'
    render :text => '', :layout => true
  end

  private

  def logout
    cookies.delete OscarsMadness::Application.config.session_options.fetch(:key).to_sym
    reset_session
  end

end
