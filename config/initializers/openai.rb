# OpenAI Configuration
OpenAI.configure do |config|
  config.access_token = ENV['OPENAI_API_KEY'] || Rails.application.credentials.openai_api_key
  # log_errors ist in dieser Version nicht verfügbar
  # config.log_errors = Rails.env.development?
end
