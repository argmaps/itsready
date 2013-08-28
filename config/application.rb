require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  # Bundler.require *Rails.groups(:assets => %w(development test))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)

  # only require the given bundler groups in the environments specified here
  bundle_groups = {
    :assets     => %w{development test precompilation production},
    :app        => %w{test}, # load web gems for controllers
    :monitoring => %w{production},
    :deployment => %w{development} # change if no longer deploy from dev box
  }
  Bundler.require *Rails.groups(bundle_groups)
end

unless ENV['RUNNING_ON_HEROKU'] == 'true'
  ENV.update YAML.load(File.read(File.expand_path('../application.yml', __FILE__)))
end

module Itsready
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

    config.autoload_paths += %W(#{config.root}/services)

    # list asset files to be precompiled for production
    config.assets.precompile = [
      'application.css','application.js',
      'glyphicons-halflings.png', 'glyphicons-halflings-white.png',
      'select2.png', 'select2-spinner.gif',
      'Flat-UI-Icons-24.woff',
      'Flat-UI-Icons-24.ttf',
      'Flat-UI-Icons-24.svg'
    ]
  end
end
