ENV['RACK_ENV'] = 'test'
require_relative '../config/environment'
require 'webmock/rspec'
require 'support/webmock_support'
require 'support/chatbot_helper'
require 'dotenv/load'



set :environment, :test
set :run, false
set :raise_errors, true


def app
  Rack::Builder.parse_file(File.expand_path('../../config.ru', __FILE__)).first 
end


include Rack::Test::Methods
include Facebook::Messenger


WebMock.disable_net_connect!(allow_localhost: true)
include WebMock::API
include WebmockSupport

stub_facebook_access_token

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

end
