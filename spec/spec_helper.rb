require 'simplecov'
require 'simplecov-rcov'

SimpleCov.start do
  add_filter 'factories'

  add_group 'Models', 'models'
  add_group 'Controllers', 'controllers'
  add_group 'Helpers', 'helpers'
  add_group 'Views', 'views'
  add_group 'Mailers', 'mailers'
  add_group 'Libraries', 'lib'
  add_group 'Routing', 'routing'
  add_group 'Features', 'features'
  #add_group 'Requests', 'requests'
end

SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

include Warden::Test::Helpers
Warden.test_mode!

Capybara.javascript_driver = :webkit
Capybara.default_wait_time = 5
Capybara.register_driver :selenium do |app|
  http_client = Selenium::WebDriver::Remote::Http::Default.new
  http_client.timeout = 100
  Capybara::Selenium::Driver.new(app, :browser => :firefox, :http_client => http_client)
end

RSpec.configure do |config|
  Spork.each_run do
    FactoryGirl.reload
  end

  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL

  # for devise test helper
  config.include Devise::TestHelpers, :type => :controller

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.include LoginMacros
end
