# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  helper :all
  
  filter_parameter_logging :password
  
  protected
  
  def authenticate
    authenticate_or_request_with_http_basic do |name, password|
      player = Player.find_by_name_and_password(name, password)
      return false unless player
      session[:user_id] = player.id
    end
  end
  
  def authenticate_admin
    authenticate_or_request_with_http_basic do |name, password|
      true
    end
  end
  
  def logged_in_player
    @logged_in_player ||= Player.find(session[:user_id])
  end
  
  def logged_in_as_admin?
    true
  end
  
  def rescue_admin_exception(exception)
    @exception = exception
    render :template => 'shared/exception'
  end
  
end
