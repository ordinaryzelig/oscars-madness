class SessionsController < ApplicationController

  before_filter :logout, :except => [:create]

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
      redirect_to edit_picks_path
    else
      flash.now[:error] = "login failed"
      render :new
    end
  end

  def destroy
    redirect_to root_path
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
