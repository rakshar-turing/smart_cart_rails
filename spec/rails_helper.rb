# Load Rails
require File.expand_path('../config/environment', __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
# spec/rails_helper.rb
require 'spec_helper'
require 'rspec/rails'
require 'pundit/rspec'
require 'pundit/matchers'


# FactoryBot and Devise setup
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include Pundit::Matchers
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Devise::Test::ControllerHelpers, type: :controller

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

RSpec.configure do |config|
  config.before(:each, type: :request) do
    allow_any_instance_of(ActionController::Base)
      .to receive(:protect_against_forgery?).and_return(false)
  end
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.allow_remote_database_url = true
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

