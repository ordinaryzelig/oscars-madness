require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module OscarsMadness
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # omniauth middleware
    config.middleware.use OmniAuth::Builder do
      provider(
        :facebook,
        Rails.env.production? ? ENV['OSCARS_FACEBOOK_APP_ID'] : '1146881118711200',
        Rails.env.production? ? ENV['OSCARS_FACEBOOK_APP_SECRET'] : '7c082733f2191cdd4ee8fe9d6474c7f8',
        :scope      => '', # just want basic authentication.
        :secure_image_url => true, # https.
      )
    end

    # Silence the deprecation warning.
    # http://stackoverflow.com/questions/20361428/rails-i18n-validation-deprecation-warning
    config.i18n.enforce_available_locales = true

    config.assets.precompile += ['rails_admin/rails_admin.css', 'rails_admin/rails_admin.js']
  end
end
