require ::File.expand_path('../config/environment',  __FILE__)
use Rails::Rack::LogTailer
run ActionController::Dispatcher.new
