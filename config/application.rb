require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ElearningV1
  class Application < Rails::Application
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**',
      '*.{rb,yml}')]
    config.active_record.time_zone_aware_types = [:datetime, :time]
    config.i18n.default_locale = :en
    config.i18n.available_locales = [:vi, :en, :ja]
  end
end
