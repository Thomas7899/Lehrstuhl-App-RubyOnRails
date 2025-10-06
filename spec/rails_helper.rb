require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

# FactoryBot Integration
require 'factory_bot_rails'

# Shoulda Matchers für einfachere Model-Tests
require 'shoulda/matchers'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  # FactoryBot Methods verfügbar machen
  config.include FactoryBot::Syntax::Methods

  # Database Cleaner
  config.use_transactional_fixtures = true

  # Shoulda Matchers Konfiguration
  Shoulda::Matchers.configure do |shoulda_config|
    shoulda_config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!

  # System Tests mit Capybara
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless
  end

  # RSpec Konfiguration
  config.fixture_paths = ["#{::Rails.root}/spec/fixtures"]
  config.infer_spec_type_from_file_location!
end