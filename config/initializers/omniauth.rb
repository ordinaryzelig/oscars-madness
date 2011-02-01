if ENV['RAILS_ENV'] == 'production'
  app_id, app_secret = '131637476902241', '7f481555f61dcd0e8de409e6adfceed3'
else
  app_id, app_secret = '196483470361666', 'f67f6f36385e9fd3012ad866029b356c'
end
ActionController::Dispatcher.middleware.use OmniAuth::Builder do
  provider :facebook, app_id, app_secret, :scope => '' # just want basic authentication.
end
