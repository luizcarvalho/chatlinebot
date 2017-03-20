require './app'
require_relative 'bot'
require 'rack'
require 'pry'

map('/webhook') do
  run Sinatra::Application
  run Facebook::Messenger::Server
end

run Sinatra::Application
