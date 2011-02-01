class AdminController < ApplicationController

  before_filter :authenticate_admin

  rescue_from Exception, :with => 'rescue_admin_exception'

  def toggle_picks_editable
    admin_config.update_attributes! :picks_editable => !admin_config.picks_editable
    redirect_to root_path
  end

end
