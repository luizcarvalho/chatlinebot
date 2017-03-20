require 'sinatra'
require 'dotenv/load'
require 'rack'
require 'loga'

Loga.configure(
  format: :gelf,
  service_name: 'my_app',
  tags: [:uuid]
)
use Loga::Rack::RequestId
use Loga::Rack::Logger
