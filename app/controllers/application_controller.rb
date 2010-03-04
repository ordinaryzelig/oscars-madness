# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  helper :all
  helper_method :logged_in_player, :logged_in_as_admin?, :admin_config
  
  filter_parameter_logging :password
  
  protected
  
  def authenticate
    authenticate_or_request_with_http_basic do |name, password|
      player = Player.find_by_name_and_password(name, password)
      return false unless player
      session[:player_id] = player.id
    end
  end
  
  def authenticate_admin
    authenticate_or_request_with_http_basic do |name, password|
      true
    end
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
  
end
