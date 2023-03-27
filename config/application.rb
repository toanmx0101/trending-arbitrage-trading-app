# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TrendingArbitrageApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = 'UTC'
    config.active_record.default_timezone = :local
    config.action_dispatch.default_headers = {
      'Cache-Control' => 'no-cache, no-store'
    }

    config.active_job.queue_adapter = :sidekiq
    # config.eager_load_paths << Rails.root.join("extras")
    config.eager_load_paths << Rails.root.join('lib')
    config.autoload_paths << Rails.root.join('lib')
  end
end
