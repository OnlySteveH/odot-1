ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
# require 'rspec/autorun'
require 'capybara/rspec'
require 'shoulda/matchers'


Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f}


ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.include TodoListHelpers, type: :feature
  config.include RailsDomIdHelper, type: :feature
  config.include FactoryGirl::Syntax::Methods
  config.include AuthenticationHelpers::Controller, type: :controller
  config.include AuthenticationHelpers::Feature,type: :feature

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  # config.expect_with :rspec do |expectations|
  #   expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  # end
  #

  ######### That made all fail !! #############I believe I put this because of some depreciation  warning in the terminal
  # config.mock_with :rspec do |mocks|
  #   mocks.verify_partial_doubles = false
  # end
  #############################################

  # config.shared_context_metadata_behavior = :apply_to_host_groups

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"

end
