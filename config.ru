require './app'
require_relative 'bot'
require 'pry'
require 'loga'

Loga.configure(
  format: :gelf,
  service_name: 'my_app',
  tags: [:uuid]
)

map('/webhook') do
  run Sinatra::Application
  run Facebook::Messenger::Server
end

use Loga::Rack::RequestId
use Loga::Rack::Logger

run Sinatra::Application
