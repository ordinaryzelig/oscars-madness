class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in_player, :admin_config, :logged_in?, :contest_year, :previous_contest_year?

  protected

  def authenticate
    return true if logged_in?
    redirect_to login_path
    false
  end

  def logged_in_player
    @logged_in_player ||= Player.find(session[:player_id]) if session[:player_id]
  end

  def admin_config
    @admin_config ||= AdminConfig.first
  end

  def logged_in?
    logged_in_player && !session[:logged_out]
  end

  def load_contest_year
    @contest_year = params[:contest_year]
  end

  def contest_year
    @contest_year ||= Contest.years.last
  end

  def previous_contest_year?
    contest_year != Date.today.year
  end

end
