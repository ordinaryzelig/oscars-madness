class AdminController < ApplicationController
  
  before_filter :authenticate_admin
  
  rescue_from Exception, :with => 'rescue_admin_exception'
  
end
