# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  helper :all
  helper_method :logged_in_player, :logged_in_as_admin?, :admin_config, :logged_in?
  
  filter_parameter_logging :password, :confirmation_password
  
  protected
  
  def authenticate
    return true if logged_in?
    redirect_to login_path
    false
  end
  
  def authenticate_admin
    return true if logged_in_as_admin?
    redirect_to login_admin_path
    false
  end
  
  def logged_in_player
    @logged_in_player ||= Player.find(session[:player_id]) if session[:player_id]
  end
  
  def logged_in_as_admin?
    session[:admin_logged_in]
  end
  
  def admin_config
    @admin_config ||= AdminConfig.first
  end
  
  def rescue_admin_exception(exception)
    @exception = exception
    render :template => 'shared/exception'
  end
  
  def logged_in?
    return true if (logged_in_as_admin? || logged_in_player) && !session[:logged_out]
  end
  
end
