RailsAdmin.config do |config|
  config.main_app_name = ["Oscars Madness", "OscarsMadness"]

  config.authorize_with do
    authenticate_or_request_with_http_basic('Site Message') do |username, password|
      username == ENV.fetch('OSCARS_USERNAME') && password == ENV.fetch('OSCARS_PASSWORD')
    end
  end

  config.current_user_method &:logged_in_player

  config.included_models = %w[Category Film Nominee Pick Player, AdminConfig]

  config.actions do
    # root actions
    dashboard                     # mandatory

    # collection actions 
    index                         # mandatory
    new
    export
    history_index
    bulk_delete

    # member actions
    show
    edit
    delete
    history_show
    show_in_app
  end
end
